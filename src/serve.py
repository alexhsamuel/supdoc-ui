import flask
import json
import os
from   pathlib import Path

top_path = Path(os.path.abspath(__file__)).parent.parent
site_path = top_path / "build"

app = flask.Flask(__name__)


@app.route('/api/doc')
def api_test():
    with open("/home/samuel/dev/supdoc/doc.json") as file:
        jso = json.load(file)
    return flask.jsonify(jso)


@app.route('/')
@app.route('/<path:filename>')
def api_default_path(filename="index.html"):
    path = site_path / filename
    # A request not for an extant file must be an Angular HTML5 route.
    # Map it back to the SPA.
    if not path.exists():
        path = site_path / "index.html"
    return flask.send_file(str(path))



if __name__ == '__main__':
    app.debug = True
    app.run()

