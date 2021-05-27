import os
import sqlite3
import html
from dashboard.utils import sizeof_fmt
from .refresher import STATS_DB_PATH
from dashboard.utils import Timer

class S3Stats:
    def __init__(self, logger):
        self.db = S3StatsDB(logger)

    def is_ready(self):
        return self.db.is_ready()

    def get_usage_by_storage_class(self, path):
        data = self.db.query(path, children_only=False, depth=len(path.split('/'))-1)
        if len(data) == 0:
            return {}
        sclasses_dict = dict()
        for sclass in ['size_standard', 'size_ia', 'size_glacier']:
            try:
                percent = data[0][sclass] / data[0]['size']
            except ZeroDivisionError:
                percent = 0
            sclasses_dict[sclass] = {'size': sizeof_fmt(data[0][sclass]), 'percent': percent}
        return sclasses_dict

    def describe(self, node, strip=''):
        return f"{html.escape(node['path'][len(strip):])} ({node['files']} files, {sizeof_fmt(node['size'])})"

    def get_jstree_buckets(self, order):
        total = self.db.query('', 0)[0]
        buckets = self.db.query('', 1, order, children_only=True)
        return {
            "text" : "All buckets " + self.describe(total), "state": {"opened": True}, "id": "root",
            "children" : [{ "id": bucket['path'], "text" : self.describe(bucket, '/'), "children" : True } 
            for bucket in buckets]}

    def get_vega_sunburst(self, base, size):
        base_depth = len(base.split('/')) - 1
        data = {}
        for idx, row in enumerate(self.db.query(base, depth=(base_depth, base_depth + size), order='alphabetically')):
            path = row['path']
            path_split = path.split('/')
            name = path_split[-1] if path_split[-1] != '' else 'all buckets'
            data[path] = {
                'id': idx+1, 
                'size': row['size'], 
                'name': name,
                'size_fmt': sizeof_fmt(row['size']) } 
            parent_dir = '/'.join(path_split[:-1])
            if path != '' and parent_dir in data:
                data[path]['parent'] = data[parent_dir]['id']
                data[parent_dir]['size'] -= data[path]['size']

        return list(data.values())

    def get_jstree_directories(self, base, order):
        return [
            { "id": directory['path'], 
            "text" : self.describe(directory, strip=base + '/'), 
            "children" : directory['is_leaf'] == 0 } 
            for directory in self.db.query(base, order=order, children_only=True)
        ]

class S3StatsDB:
    ORDER_DEFINITION = {
        'alphabetically': 'path asc',
        'avg_file_size_desc': 'size/files asc',
        'files_desc': 'files desc',
        'size_desc': 'size desc'
    }
    def __init__(self, logger):
        self.logger = logger

    def is_ready(self):
        return os.path.exists(STATS_DB_PATH)

    def format_path_condition(self, base, children_only):
        if children_only:
            return f"path like '{base}/%'"
        else:
            return f"(path like '{base}/%' or path = '{base}')"

    def format_depth_condition(self, base, depth):
        if depth is None:
            depth = len(base.split('/'))
        if type(depth) is tuple:
            return f'depth between {depth[0]} and {depth[1]}'
        else:
            return f'depth = {depth}'

    def query(self, base, depth=None, order="size_desc", children_only=False):
        sqlite = sqlite3.connect(STATS_DB_PATH)
        sqlite.row_factory = sqlite3.Row
        order = self.ORDER_DEFINITION.get(order, self.ORDER_DEFINITION['size_desc'])
        query = f"SELECT *, (size_standard + size_ia + size_glacier) as size " \
                f"FROM stats " \
                f"WHERE {self.format_path_condition(base, children_only)} " \
                f"AND {self.format_depth_condition(base, depth)} " \
                f"order by {order}"
        with Timer(self.logger, f"S3 stats query {query}"):
            try:
                cursor = sqlite.cursor()
                cursor.execute(query)
                return cursor.fetchall()
            finally:
                cursor.close()
                sqlite.close()
