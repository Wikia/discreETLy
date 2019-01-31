import os
import sqlite3


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
