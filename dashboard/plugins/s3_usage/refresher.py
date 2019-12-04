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
from dashboard.utils import Timer

STATS_DB_PATH = '/var/run/discreetly/s3_stats.db'
STATS_DB_TMP_PATH = '/var/run/discreetly/s3_stats.db.tmp'
LOCK_PATH = '/var/run/discreetly/s3_stats.db.lock'

class S3StatsRefresher:
    def __init__(self, logger, params):
        self.logger = logger
        self.params = params
        self.validate_params()

    def validate_params(self):
        if not 'ttl' in self.params:
            self.params['ttl'] = 60 * 60 * 24 # 1 day
    def run_refresher_task(self):
        try:
            S3StatsRefreshTask(self.logger, **(self.params)).run()
            next_run_after = self.params['ttl']
        except Exception  as e:
            next_run_after = 300
            self.logger.error(f"S3StatsRefreshTask failed, will retry in 5 minutes", exc_info=e)

        threading.Timer(next_run_after, self.run_refresher_task).start()

    def start(self):
        threading.Timer(1, self.run_refresher_task).start() 

class S3StatsRefreshTask:
    CREATE_STMT = 'CREATE TABLE stats (path VARCHAR, files INTEGER, size_standard INTEGER, size_ia INTEGER, size_glacier INTEGER, depth INTEGER, is_leaf INTEGER)'
    INSERT_STMT = 'INSERT INTO stats VALUES (?, ?, ?, ?, ?, ?, ?)'

    def __init__(self, logger, buckets_regexp, aws_access_key_id, aws_secret_access_key, ttl):
        self.s3 = boto3.client('s3', 
            aws_access_key_id=aws_access_key_id,
            aws_secret_access_key=aws_secret_access_key)
        self.s3_aggregator = S3Aggregator(self.s3)
        self.buckets_regexp = buckets_regexp
        self.logger = logger
        self.ttl = ttl

    def needs_refresh(self):
        try:
            return time.time() - os.stat(STATS_DB_PATH).st_mtime > self.ttl
        except FileNotFoundError:
            return True

    def list_buckets(self):
        return [bucket['Name'] for bucket in self.s3.list_buckets()['Buckets'] 
                                            if re.match(self.buckets_regexp, bucket['Name'])]

    def run(self):
        with open(LOCK_PATH, 'w') as lock:
            self.logger.debug("Trying to acquire the S3Stats lock")
            fcntl.flock(lock, fcntl.LOCK_EX)
            self.logger.debug("S3Stats Lock acquired")
            if not self.needs_refresh():
                self.logger.info("No need to refresh S3Stats, exiting")
                return

            if os.path.exists(STATS_DB_TMP_PATH):
                os.remove(STATS_DB_TMP_PATH)
            self.sqlite = sqlite3.connect(STATS_DB_TMP_PATH)
            self.sqlite.execute(self.CREATE_STMT)
            self.sqlite.commit()

            buckets = self.list_buckets()
            self.logger.info(f"Downloading stats for buckets {buckets}")
            global_stats = KeyPrefix()
            for bucket in buckets:
                data = self.load_s3_bucket(bucket)
                bucket_stats = self.dump_s3_bucket(data, bucket)
                global_stats += bucket_stats

            self.sqlite.execute(self.INSERT_STMT, ("", global_stats.files, global_stats.size_standard, global_stats.size_ia, global_stats.size_glacier, 0, 0))
            self.sqlite.commit()
            self.sqlite.close()
            os.rename(STATS_DB_TMP_PATH, STATS_DB_PATH)

    def insert_iterator(self, bucket, data):
        parents = set([path[:path.rfind('/')] for path in data.keys()])
        for key in data:
            key_fixed = key.rstrip('/')
            is_leaf = not key in parents
            yield f"/{bucket}{key_fixed}", data[key].files, \
                data[key].size_standard, data[key].size_ia, data[key].size_glacier, \
                len(key_fixed.split('/')), int(is_leaf)

    def load_s3_bucket(self, bucket):
        with Timer(self.logger, f"Listing bucket {bucket}"):
            data = self.s3_aggregator.load(bucket)
            self.logger.info(f"Listed {len(data)} directories ({data['/'].files} files) in bucket {bucket}")
            return data
    
    def dump_s3_bucket(self, data, bucket):
        with Timer(self.logger, f"Dumping bucket {bucket} to DB"):
            self.sqlite.execute('BEGIN')
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