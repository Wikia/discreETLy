import MySQLdb
import MySQLdb.cursors
import _mysql_exceptions
from timeit import default_timer as timer
import inspect
import queue
import backoff


class MySQLClientTimer:

    def __init__(self, logger):
        self.logger = logger
        self.query = next(call.function for call in inspect.stack()[2:] if call.function != 'retry') # first call that is not retry

    def __enter__(self):
        self.start = timer()
        self.logger.debug(f"MySQL query {self.query} started")
        return self

    def __exit__(self, *args):
        self.end = timer()
        self.interval = self.end - self.start
        self.logger.info(f"MySQL query for {self.query} took {self.interval:.2f} sec")


class MySQLClient:

    def __init__(self, config, logger, pool_size=3):
        self.config = config
        self.logger = logger
        self.pool = queue.Queue()
        for _ in range(pool_size):
            self.pool.put(self.create_connection())

    def create_connection(self):
        conn = MySQLdb.connect(
                host=self.config['AIRFLOW_DB_HOST'],
                user=self.config['AIRFLOW_USERNAME'],
                password=self.config['AIRFLOW_PASSWORD'],
                db=self.config['AIRFLOW_DATABASE'],
                cursorclass=MySQLdb.cursors.DictCursor,
                connect_timeout=3
            )
        conn.autocommit(True)
        return conn

    @backoff.on_exception(backoff.expo, _mysql_exceptions.OperationalError, max_tries=4)
    def query(self, query):
        cursor = None
        conn = self.pool.get(True)
        try:
            with MySQLClientTimer(self.logger):
                cursor = conn.cursor()
                cursor.execute(query)
                return cursor.fetchall()
        except _mysql_exceptions.OperationalError:
            conn = self.create_connection() # recreate connection
            raise
        finally:
            if cursor is not None:
                cursor.close()
            self.pool.put(conn)
