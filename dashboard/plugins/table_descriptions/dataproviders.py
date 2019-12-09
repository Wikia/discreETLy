from collections import defaultdict
from timeit import default_timer as timer

import boto3
import json

from flask import current_app as app


class GlueTimer:

    def __init__(self, logger):
        self.logger = logger

    def __enter__(self):
        self.start = timer()
        self.logger.debug(f"Glue description fetch started")
        return self

    def __exit__(self, *args):
        self.end = timer()
        self.interval = self.end - self.start
        self.logger.info(f"Glue description fetch took {self.interval:.2f} sec")

class GlueDescriptionService:

    def __init__(self, logger, config, tables, region_name, aws_access_key_id, aws_secret_access_key):
        self.client = boto3.client('glue',
                                   region_name=region_name,
                                   aws_access_key_id=aws_access_key_id,
                                   aws_secret_access_key=aws_secret_access_key)
        self.logger = logger
        self.db_tables = self.get_db_tables(tables)


    @staticmethod
    def get_db_tables(tables):
        result = defaultdict(list)
        for table in tables.values():
            result[table.db].append(table.name)
        return result

    def get_tables_for_db(self, db, tables):
        """
        Get tables with their columns and descriptions for a given db
        :param db: Name of database
        :param tables: List of table names
        :return: List of table dicts (name = table name, columns = list of dicts with 'name' and 'comment' keys)
        """
        try:
            glue_tables = self.client.get_tables(DatabaseName=db, MaxResults=1000)
            result_tables = []
            for table in glue_tables['TableList']:
                columns = [{'name': column['Name'],
                            'description': column.get('Comment', ''),
                            'is_partition': False,
                            'type': column.get('Type')}
                           for column in table['StorageDescriptor']['Columns']]

                columns.extend([{'name': column['Name'],
                                 'description': column.get('Comment', ''),
                                 'is_partition': True,
                                 'type': column.get('Type')}
                                for column in table.get('PartitionKeys', [])])

                result_tables.append({'name': table['Name'],
                                      'description': table.get('Parameters', {}).get('comment', ''),
                                      'columns': columns})

                result_tables = [t for t in result_tables if t['name'] in tables]
            return sorted(result_tables, key=lambda k: k['name'])
        except Exception as e:
            self.logger.warn('Exception caught while trying to get table descriptions', e)
            return []


    def get_table_descriptions(self):
        """
        Returns a dict of key = 'db_name.table_name' and
        value = dict with table description and list of column dicts with name, type and description fields
        """
        futures = list()
        with GlueTimer(self.logger):
            for db, tables in self.db_tables.items():
                futures.append((db, app.async_request_executor.submit(self.get_tables_for_db, db, tables)))

            tables_metadata = dict()
            for db, tables in futures:
                for table in tables.result():
                    tables_metadata['{}.{}'.format(db, table['name'])] = table

        for table_name, metadata in tables_metadata.items():
            try:
                td_dict = json.loads(metadata['description'])
                metadata['description'] = td_dict['table_description']
                metadata['last_description_update'] = td_dict['last_update_timestamp']
            except ValueError as err:
                metadata['previous_description_update'] = ''

            for column in metadata['columns']:
                try:
                    cd_dict = json.loads(column['description'])
                    column['description'] = cd_dict['column_description']
                    column['last_description_update'] = cd_dict['last_update_timestamp']
                    column['example'] = cd_dict['example']
                except ValueError as err:
                    column['last_description_update'] = ''
                    column['example'] = ''

        return tables_metadata
