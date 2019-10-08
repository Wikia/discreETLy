import sqlite3
from dashboard.service.mysql import MySQLClient
import logging
import time

class SqliteService:

    def __init__(self, location=':memory:'):
        self.conn: sqlite3.Connection = sqlite3.connect(location)
        self.conn.row_factory = sqlite3.Row

    @staticmethod
    def migrate(client: sqlite3.Connection, migration_script):
        cursor: sqlite3.Cursor = client.cursor()
        with open(migration_script, 'r') as script:
            cursor.executescript(script.read())
        client.commit()
        cursor.close()

    def query(self, query: str):
        try:
            cursor = self.conn.cursor()
            cursor.execute(query.replace('\n', ''))
            self.conn.commit()
            return [dict(item) for item in cursor.fetchall()]
        finally:
            cursor.close()

class MysqlService:

    def __init__(self):
        configuration = {
            'AIRFLOW_DB_HOST': 'tests_mysql_1',
            'AIRFLOW_USERNAME': 'root',
            'AIRFLOW_PASSWORD': 'test',
            'AIRFLOW_DATABASE': 'pytest'
        }

        logger = logging.getLogger('pytest')

        retries = 0
        connected = False
        last_error = None
        while not connected and retries < 10:
            try:
                self.db = MySQLClient(configuration, logger)
                connected = True
            except Exception as e:
                print("Waiting for database...")
                time.sleep(1)
                last_error = e
                retries = retries + 1

        if not connected:
            raise RuntimeError("Cannot connect to the test database") from last_error

    def migrate(self, migration_script):
        with open(migration_script, 'r') as script:
            self.db.query(script.read())

    def query(self, query: str):
        return self.db.query(query)
