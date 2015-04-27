import argparse
import flask
import json
import logging
import os
from   pathlib import Path

app = flask.Flask(__name__)


# API entry points are under /api.

def get_doc():
    try:
        return get_doc.__cache__
    except AttributeError:
        with open(os.path.expanduser("~/dev/supdoc/doc.json")) as file:
            doc = json.load(file)
        get_doc.__cache__ = doc
        return doc


@app.route("/api/modules")
def api_modules():
    doc = get_doc()
    # Return only module names.
    modules = {"modules": { m: None for m in doc["modules"] }}
    return flask.jsonify(modules)


@app.route("/api/modules/<string:module>")
def api_module(module):
    modules = get_doc()["modules"]
    try:
        doc = modules[module]
    except KeyError:
        error = {"error": "module {} not found".format(module)}
        return flask.make_response(flask.jsonify(error), 404)
    else:
        return flask.jsonify({"modules": {module: doc}})


# The Angular app's paths are all under /ui.

@app.route("/ui")
@app.route("/ui/")
@app.route("/ui/<path:filename>")
def api_ui(filename=None):
    return flask.send_file(str(site_path / "index.html"))


# Everything else is served statically.

@app.route("/<path:filename>")
def api_static(filename):
    return flask.send_from_directory(str(site_path), filename)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--development", default=False, action="store_true",
        help="run a development server")
    args = parser.parse_args()

    global site_path
    top_path = Path(os.path.abspath(__file__)).parent.parent
    if args.development:
        site_path = top_path / "build"
        app.debug = True
    else:
        site_path = top_path / "bin"

    app.run()



if __name__ == '__main__':
    main()
