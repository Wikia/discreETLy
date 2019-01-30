from flask import Blueprint, render_template, jsonify, request, abort
from flask import current_app as app
from .s3_stats import S3Stats
from dashboard.utils import sizeof_fmt
import html

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

    return render_template('s3_usage/index.html', 
            storage_classes=app.s3stats.get_usage_by_storage_class(""))

def describe(node, strip=''):
    return f"{html.escape(node['path'][len(strip):])} ({node['files']} files, {sizeof_fmt(node['size'])})"

@plugin.route('/api/buckets')
def list_buckets():
    total = app.s3stats.query('', 0)[0]
    order = request.args.get('order')
    buckets = app.s3stats.query('', 1, order, children_only=True)

    return jsonify({
         "text" : "All buckets " + describe(total), "state": {"opened": True}, "id": "root",
         "children" : [{ "id": bucket['path'], "text" : describe(bucket, '/'), "children" : True } 
         for bucket in buckets]})

@plugin.route('/api/directories')
def list_directories():
    base = request.args.get('id')
    order = request.args.get('order')

    return jsonify([
        { "id": directory['path'], 
          "text" : describe(directory, strip=base + '/'), 
          "children" : directory['is_leaf'] == 0 } 
         for directory in app.s3stats.query(base, order=order, children_only=True)])


@plugin.route('/api/sunburst')
def prepare_sunburst():
    size = 3
    base_path = request.args.get('base')
    base_depth = len(base_path.split('/')) - 1
    data = {}
    for idx, row in enumerate(app.s3stats.query(base_path, depth=(base_depth, base_depth + size), order='alphabetically')):
        path = row['path']
        path_split = path.split('/')
        data[path] = {
            'id': idx+1, 
            'size': row['size'], 
            'name': path_split[-1],
            'size_fmt': sizeof_fmt(row['size']) } 
        parent_dir = '/'.join(path_split[:-1])
        if path != '' and parent_dir in data:
            data[path]['parent'] = data[parent_dir]['id']
            data[parent_dir]['size'] -= data[path]['size']

    return jsonify(list(data.values()))

@plugin.route('/ajax/storage_classes')
def render_storage_classes():
    path = request.args.get('path')
    return render_template('s3_usage/partial_storage_classes.html', 
            storage_classes=app.s3stats.get_usage_by_storage_class(path))