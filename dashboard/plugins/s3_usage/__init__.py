from flask import Blueprint, render_template, jsonify, request
from flask import current_app as app
from .s3_stats import S3Stats
from dashboard.utils import sizeof_fmt

base_path = '/s3_usage'
tab_name = 'S3 Usage'
plugin = Blueprint('s3_usage', __name__, template_folder='templates')


def init(app):
    app.s3stats = S3Stats(app.logger, app.config['S3_USAGE_PARAMS'])
    app.s3stats.start_refresher()

@plugin.route('/')
def index():
    if not app.s3stats.is_ready():
        return render_template('s3_usage/initializing.html')

    return render_template('s3_usage/index.html')

def describe(node):
    return f"{node['path']} ({node['files']} files, {sizeof_fmt(node['size'])})"

@plugin.route('/api/buckets')
def list_buckets():
    total = app.s3stats.query('/', 0)[0]
    buckets = app.s3stats.query('/', 1)

    return jsonify({
         "text" : describe(total), "state": {"opened": True},
         "children" : [{ "id": bucket['path'], "text" : describe(bucket), "children" : True } 
         for bucket in buckets]})

@plugin.route('/api/directories')
def list_directories():
    base = request.args.get('id')

    return jsonify([
        { "id": directory['path'], 
          "text" : describe(directory), 
          "children" : True } 
         for directory in app.s3stats.query(base + '/')])