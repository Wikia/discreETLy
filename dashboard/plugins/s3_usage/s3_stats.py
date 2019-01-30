import boto3
import sqlite3
import fcntl
import os
import time
import threading
import re
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from dataclasses import dataclass
from dashboard.utils import sizeof_fmt

class S3Stats:
    ORDER_DEFINITION = {
        'alphabetically': 'path asc',
        'avg_file_size_desc': 'size/files asc',
        'files_desc': 'files desc',
        'size_desc': 'size desc'
    }
    def __init__(self, logger, params):
        self.logger = logger
        self.params = params
        self.validate_params()

    def validate_params(self):
        if not 'ttl' in self.params:
            self.params['ttl'] = 60 * 60 * 24 # 1 day

    def is_ready(self):
        return os.path.exists(S3StatsRefreshTask.STATS_DB_PATH)

    def get_usage_by_storage_class(self, path):
        data = self.query(path, children_only=False, depth=len(path.split('/'))-1)
        if len(data) == 0:
            return {}

        return {
            sclass: {
                'size': sizeof_fmt(data[0][sclass]),
                'percent': data[0][sclass] / data[0]['size']
            } for sclass in ['size_standard', 'size_ia', 'size_glacier']
        }
        

    def query(self, base, depth=None, order="size_desc", children_only=False):
        if depth is None:
            depth = len(base.split('/'))
        if type(depth) is tuple:
            depth_condition = f'depth between {depth[0]} and {depth[1]}'
        else:
            depth_condition = f'depth = {depth}'

        if children_only:
            path_condition = f"path like '{base}/%'"
        else:
            path_condition = f"(path like '{base}/%' or path = '{base}')"

        sqlite = sqlite3.connect(S3StatsRefreshTask.STATS_DB_PATH)
        sqlite.row_factory = sqlite3.Row
        cursor = sqlite.cursor()
        order = self.ORDER_DEFINITION.get(order, self.ORDER_DEFINITION['size_desc'])
        query = f"SELECT *, (size_standard + size_ia + size_glacier) as size FROM stats WHERE {path_condition} and {depth_condition} order by {order}"
        self.logger.debug(f"S3Stats: Executing query: {query}")
        cursor.execute(query)
        result = cursor.fetchall() 
        cursor.close()
        sqlite.close()
        return result

    def run_refresher_task(self):
        try:
            S3StatsRefreshTask(self.logger, **(self.params)).run()
            next_run_after = self.params['ttl']
        except:
            next_run_after = 300
            self.logger.error(f"S3StatsRefreshTask failed, will retry in 5 minutes")

        threading.Timer(next_run_after, self.run_refresher_task).start()

    def start_refresher(self):
        threading.Timer(1, self.run_refresher_task).start() 

class S3StatsRefreshTask:
    STATS_DB_PATH = '/var/run/s3_stats.db'
    STATS_DB_TMP_PATH = '/var/run/s3_stats.db.tmp'
    LOCK_PATH = '/var/run/s3_stats.db.lock'
    CREATE_STMT = 'CREATE TABLE stats (path VARCHAR, files INTEGER, size_standard INTEGER, size_ia INTEGER, size_glacier INTEGER, depth INTEGER, is_leaf INTEGER)'
    INSERT_STMT = 'INSERT INTO stats VALUES (?, ?, ?, ?, ?, ?, ?)'

    def __init__(self, logger, buckets_regexp, aws_access_key_id, aws_secret_access_key, ttl):
        s3 = boto3.client('s3', 
            aws_access_key_id=aws_access_key_id,
            aws_secret_access_key=aws_secret_access_key)
        self.s3_aggregator = S3Aggregator(s3)
        self.buckets = [bucket['Name'] for bucket in s3.list_buckets()['Buckets'] 
                                            if re.match(buckets_regexp, bucket['Name'])]
        self.logger = logger
        self.ttl = ttl

    def needs_refresh(self):
        try:
            return time.time() - os.stat(self.STATS_DB_PATH).st_mtime > self.ttl
        except FileNotFoundError:
            return True

    def run(self):
        with open(self.LOCK_PATH, 'w') as lock:
            self.logger.debug("Trying to acquire the S3Stats lock")
            fcntl.flock(lock, fcntl.LOCK_EX)
            self.logger.debug("S3Stats Lock acquired")
            if not self.needs_refresh():
                self.logger.info("No need to refresh S3Stats, exiting")
                return

            self.sqlite = sqlite3.connect(self.STATS_DB_TMP_PATH, isolation_level="EXCLUSIVE")
            self.sqlite.execute(self.CREATE_STMT)
            self.sqlite.commit()
            self.logger.info(f"Downloading stats for buckets {self.buckets}")

            global_stats = KeyPrefix()
            for bucket in self.buckets:
                data = self.load_s3_bucket(bucket)
                bucket_stats = self.dump_s3_bucket(data, bucket)
                global_stats += bucket_stats

            self.sqlite.execute(self.INSERT_STMT, ("", global_stats.files, global_stats.size_standard, global_stats.size_ia, global_stats.size_glacier, 0, 0))
            self.sqlite.commit()
            self.sqlite.close()
            os.rename(self.STATS_DB_TMP_PATH, self.STATS_DB_PATH)

    def insert_iterator(self, bucket, data):
        for key in data:
            key_fixed = key.rstrip('/')
            is_leaf = sum([1 for path in data.keys() if path.startswith(key)]) == 1
            yield f"/{bucket}{key_fixed}", data[key].files, \
                data[key].size_standard, data[key].size_ia, data[key].size_glacier, \
                len(key_fixed.split('/')), int(is_leaf)

    def load_s3_bucket(self, bucket):
        self.logger.info(f"Dumping bucket {bucket}")
        start = time.time()
        data = self.s3_aggregator.load(bucket)
        self.logger.info(f"It took {format(time.time() - start, '.2f')}s to download information about {len(data)} directories "
                         f"({data['/'].files} files) in bucket {bucket}")
        return data
    
    def dump_s3_bucket(self, data, bucket):
        self.sqlite.executemany(self.INSERT_STMT, self.insert_iterator(bucket, data))
        self.sqlite.commit()
        return data['/']

@dataclass
class KeyPrefix:
    files:int = 0
    size_standard:int = 0
    size_ia:int = 0
    size_glacier:int = 0

    def add_file(self, size, storage_class):
        self.files += 1
        if storage_class == 'STANDARD_IA':
            self.size_ia += size
        elif storage_class == 'GLACIER':
            self.size_glacier += size
        else:
            self.size_standard += size
            
    def __add__(self, other):
        merged = KeyPrefix()
        merged.files = self.files + other.files
        merged.size_standard = self.size_standard + other.size_standard
        merged.size_ia = self.size_ia + other.size_ia
        merged.size_glacier = self.size_glacier + other.size_glacier
        return merged

class S3Aggregator:
    def __init__(self, s3):
        self.s3 = s3
    
    def load(self, bucket):
        db = defaultdict(KeyPrefix)
        
        for page in self.s3.get_paginator('list_objects_v2').paginate(Bucket=bucket):
            for obj in page.get('Contents', ()):
                key_parts = obj['Key'].split('/')
                for i in range(len(key_parts)):
                    if key_parts[i] == '':
                        key_parts[i] = '<empty>'
                for depth in range(len(key_parts)):
                    path = '/' + '/'.join(key_parts[:depth])
                    db[path].add_file(obj['Size'], obj['StorageClass'])

        return db