import html
from flask import Blueprint, render_template, jsonify, request, abort
from flask import current_app as app
from .refresher import S3StatsRefresher
from .statsdb import S3Stats
from dashboard.utils import sizeof_fmt

base_path = '/s3_usage'
tab_name = 'S3 Usage'
plugin = Blueprint('s3_usage', __name__, template_folder='templates')

def init(app):
    S3StatsRefresher(app.logger, app.config['S3_USAGE_PARAMS']).start()
    app.s3stats = S3Stats(app.logger)

@plugin.route('/')
def index():
    if not app.s3stats.is_ready():
        return render_template('s3_usage/initializing.html')

    return render_template('s3_usage/index.html', 
            storage_classes=app.s3stats.get_usage_by_storage_class(""))

@plugin.route('/api/buckets')
def list_buckets():
    order = request.args.get('order')
    return jsonify(app.s3stats.get_jstree_buckets(order))

@plugin.route('/api/directories')
def list_directories():
    base = request.args.get('id')
    order = request.args.get('order')
    return jsonify(app.s3stats.get_jstree_directories(base, order))

@plugin.route('/api/sunburst')
def prepare_sunburst():
    size = 3
    base_path = request.args.get('base')
    return jsonify(app.s3stats.get_vega_sunburst(base_path, size))

@plugin.route('/ajax/storage_classes')
def render_storage_classes():
    path = request.args.get('path')
    return render_template('s3_usage/partial_storage_classes.html', 
            storage_classes=app.s3stats.get_usage_by_storage_class(path))