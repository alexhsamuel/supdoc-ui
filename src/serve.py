import flask
import os
from   pathlib import Path

top_path = Path(os.path.abspath(__file__)).parent.parent
site_path = top_path / "build"
src_path = site_path / "src"
vendor_path = site_path / "vendor"

app = flask.Flask(__name__)


@app.route('/index.html')
def static_index():
    return flask.send_file(str(site_path / "index.html"))


@app.route('/templates-common.js')
def static_templates_common():
    return flask.send_file(str(site_path / "templates-common.js"))


@app.route('/templates-app.js')
def static_templates_app():
    return flask.send_file(str(site_path / "templates-app.js"))


@app.route('/assets/<path:filename>')
def static_assets(filename):
    return flask.send_from_directory(str(site_path / "assets"), filename)


@app.route('/src/<path:filename>')
def static_src(filename):
    return flask.send_from_directory(str(src_path), filename)


@app.route('/vendor/<path:filename>')
def static_vendor(filename):
    return flask.send_from_directory(str(vendor_path), filename)


@app.route('/api/test')
def api_test():
    return flask.jsonify({"result": "OK"})


@app.route('/')
@app.route('/<path:filename>')
def api_default_path(filename=None):
    return flask.send_file(str(site_path / "index.html"))


if __name__ == '__main__':
    app.debug = True
    app.run()

