import os
import sqlite3


class SqliteService:

    def __init__(self):
        self.conn: sqlite3.Connection = sqlite3.connect(':memory:')
        self.conn.row_factory = sqlite3.Row

    @staticmethod
    def migrate(client: sqlite3.Connection, migration_script):
        cursor: sqlite3.Cursor = client.cursor()
        with open(os.path.join(os.path.dirname(os.path.abspath(__file__)), migration_script), 'r') as script:
            cursor.executescript(script.read())
        client.commit()
        cursor.close()

    def query(self, query: str):
        try:
            cursor = self.conn.cursor()
            cursor.execute(query.replace('\n', ''))
            self.conn.commit()
            return cursor.fetchall()
        finally:
            cursor.close()
