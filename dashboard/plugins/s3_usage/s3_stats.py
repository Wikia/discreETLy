import boto3
import sqlite3
import fcntl
import os
import time
import threading
import re
from collections import defaultdict

class S3Stats:
    def __init__(self, logger, params):
        self.logger = logger
        self.params = params
        self.validate_params()

    def validate_params(self):
        if not 'ttl' in self.params:
            self.params['ttl'] = 60 * 60 * 24 # 1 day
        if not 'check_every' in self.params:
            self.params['check_every'] = 60 * 60 # 1 hour

    def is_ready(self):
        return os.path.exists(S3StatsRefreshTask.STATS_DB_PATH)

    def query(self, base, depth=None):
        if depth is None:
            depth = len(base.split('/')) - 1
        sqlite = sqlite3.connect(S3StatsRefreshTask.STATS_DB_PATH)
        sqlite.row_factory = sqlite3.Row
        cursor = sqlite.cursor()
        cursor.execute(f"SELECT * FROM stats WHERE path like '{base}%' and depth = {depth} order by size desc")
        result = cursor.fetchall() 
        cursor.close()
        sqlite.close()
        return result

    def run_refresher_task(self):
        S3StatsRefreshTask(self.logger, **(self.params)).run()
        threading.Timer(self.params['check_every'], self.run_refresher_task).start()

    def start_refresher(self):
        threading.Timer(1, self.run_refresher_task).start() 

class S3StatsRefreshTask:
    STATS_DB_PATH = '/var/run/s3_stats.db'
    STATS_DB_TMP_PATH = '/var/run/s3_stats.db.tmp'
    LOCK_PATH = '/var/run/s3_stats.db.lock'
    CREATE_STMT = 'CREATE TABLE stats (path VARCHAR, files INTEGER, size INTEGER, depth INTEGER)'
    INSERT_STMT = 'INSERT INTO stats VALUES (?, ?, ?, ?)'

    def __init__(self, logger, buckets_regexp, aws_access_key_id, aws_secret_access_key, check_every, ttl):
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
            total_size = 0
            total_files = 0
            self.logger.info(f"Downloading stats for buckets {self.buckets}")
            for bucket in self.buckets:
                bucket_files, bucket_size = self.dump_s3_bucket(bucket)
                total_size += bucket_size
                total_files += bucket_files

            self.sqlite.execute(self.INSERT_STMT, ("/", total_files, total_size, 0))
            self.sqlite.commit()
            self.sqlite.close()
            os.rename(self.STATS_DB_TMP_PATH, self.STATS_DB_PATH)

    def insert_iterator(self, bucket, data):
        for key in data:
            key_fixed = key.rstrip('/')
            yield f"/{bucket}{key_fixed}", data[key].files, data[key].size, len(key_fixed.split('/'))
    
    def dump_s3_bucket(self, bucket):
        self.logger.info(f"Dumping bucket {bucket}")
        start = time.time()
        data = self.s3_aggregator.load(bucket)
        self.logger.info(f"It took {format(time.time() - start, '.2f')}s to download information about {len(data)} directories "
                         f"({data['/'].files} files) in bucket {bucket}")
        self.sqlite.executemany(self.INSERT_STMT, self.insert_iterator(bucket, data))
        self.sqlite.commit()
        return data['/'].files, data['/'].size


class KeyPrefix:
    def __init__(self):
        self.files = 0
        self.size = 0

    def add_file(self, size):
        self.files += 1
        self.size += size

    def add_files(self, size):
        self.files += 1
        self.size += size

class S3Aggregator:
    def __init__(self, s3):
        self.s3 = s3
    
    def load(self, bucket):
        db = defaultdict(KeyPrefix)
        
        for page in self.s3.get_paginator('list_objects_v2').paginate(Bucket=bucket):
            for obj in page.get('Contents', ()):
                key_parts = obj['Key'].split('/')
                for depth in range(len(key_parts)):
                    path = '/' + '/'.join(key_parts[:depth])
                    db[path].add_file(obj['Size'])

        return db