from collections import defaultdict

import boto3

from flask import current_app as app


class GlueDescriptionService:

    def __init__(self, config, tables):
        self.client = boto3.client('glue', region_name=config['GLUE_REGION_NAME'])

        self.db_tables = self.get_db_tables(tables)

    @staticmethod
    def get_db_tables(tables):
        result = defaultdict(lambda: list())
        for table in tables:
            result[table.db].append(table.name)
        return result

    def get_tables_for_db(self, db, tables):
        """
        Get tables with their columns and descriptions for a given db
        :param db: Name of database
        :param tables: List of table names
        :return: List of table dicts (name = table name, columns = list of dicts with 'name' and 'comment' keys)
        """
        glue_tables = self.client.get_tables(DatabaseName=db, MaxResults=1000)
        glue_tables = [{'name': table['Name'], 'columns': [{'name': column['Name'],
                                                            'description': column.get('Comment'),
                                                            'type': column.get('Type')}
                                                           for column in table['StorageDescriptor']['Columns']]} for
                       table in glue_tables['TableList']]
        glue_tables = [t for t in glue_tables if t['name'] in tables]
        return sorted(glue_tables, key=lambda k: k['name'])


    def get_table_descriptions(self):
        """
        Returns a dict of key = 'db_name.table_name' and
        value = list of column dicts with name, type and description fields
        """
        futures = list()

        for db, tables in self.db_tables.items():
            futures.append((db, app.async_request_executor.submit(self.get_tables_for_db, db, tables)))

        result = dict()
        for db, tables in db, tables in futures:
            for table in tables.result():
                result['{}.{}'.format(db, table['name'])] = table['columns']

        return result
