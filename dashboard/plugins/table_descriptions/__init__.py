from flask import Blueprint
from flask import render_template
from flask import current_app as app
from flask import request
from dashboard.utils import load_data_provider

import boto3
import json
import datetime

base_path = '/table_descriptions'
tab_name = 'Table descriptions'
plugin = Blueprint('table_descriptions', __name__, template_folder='templates')

def splitpart (value, index, char = ','):
    return value.split(char)[index]

DEFAULT_CACHE = 300
def get_descriptions():
    cache_ttl = app.config.get('TABLE_DESCRIPTIONS_TTL', DEFAULT_CACHE)
    descriptions = app.cache.get('table_descriptions')
    if descriptions is not None:
        return descriptions

    classname = app.config['TABLE_DESCRIPTIONS_SERVICE']
    params = app.config['TABLE_DESCRIPTIONS_SERVICE_PARAMS']
    params['logger'] = app.logger
    params['config'] = app.config
    params['tables'] = app.table_data_provider.tables

    descriptions = load_data_provider(classname, params).get_table_descriptions()
    app.cache.set('table_descriptions', descriptions, timeout=cache_ttl)
    app.jinja_env.filters['splitpart'] = splitpart
    return descriptions

@plugin.route('/')
def index():
    if not 'TABLE_DESCRIPTIONS_SERVICE' in app.config or app.table_data_provider is None:
        return render_template('no_config.html', filename='TABLE_DESCRIPTIONS_SERVICE')

    return render_template('table_descriptions/index.html', tables=get_descriptions())

"""
Commits an update to glue with a new description of a given column from a submitted form
"""
@plugin.route('/post_update_column')
def update_column():
    # fetch data from the submitted form
    column_description = request.args.get('column_description')
    example = request.args.get('example')
    table_name = request.args.get('table_name')
    namespace = request.args.get('namespace')
    col_to_update = request.args.get('column')
    # we connect to aws glue and fetch old metadata of the column
    glue = boto3.client('glue',
                            aws_access_key_id=app.config['ATHENA_USAGE_PARAMS']['aws_access_key_id'],
                            aws_secret_access_key=app.config['ATHENA_USAGE_PARAMS']['aws_secret_access_key'],
                            region_name=app.config['ATHENA_USAGE_PARAMS']['region_name'])
    table_data = glue.get_table(DatabaseName = namespace, Name = table_name)
    # update the description in the metadata of the column and prepare data to send to glue
    columns_data = table_data['Table']['StorageDescriptor']['Columns']
    now = datetime.datetime.now()
    comment_dict = dict([('column_description', column_description),
                         ('example', example),
                         ('last_update_timestamp', now.strftime('%Y-%m-%dT%H:%M:%S'))])
    for col in columns_data:
        if col['Name'] == col_to_update:
            col['Comment'] = json.dumps(comment_dict, ensure_ascii=False)
    update_dict = table_data['Table']
    keys_to_delete = ['DatabaseName', 'UpdateTime', 'IsRegisteredWithLakeFormation']
    for key in keys_to_delete:
        del(update_dict[key])
    # submit an update request to glue
    glue.update_table(DatabaseName='test', TableInput=update_dict)
    app.cache.clear()
    return index()

"""
Commits an update to glue with a new description of a given table from a submitted form
"""
@plugin.route('/post_update_table')
def update_table():

    #table_description=opis+audience+sizingu&namespace=test&table_name=audience_sizing

    # fetch data from the submitted form
    table_description = request.args.get('table_description')
    table_name = request.args.get('table_name')
    namespace = request.args.get('namespace')
    # we connect to aws glue and fetch old metadata of the column
    glue = boto3.client('glue',
                            aws_access_key_id=app.config['ATHENA_USAGE_PARAMS']['aws_access_key_id'],
                            aws_secret_access_key=app.config['ATHENA_USAGE_PARAMS']['aws_secret_access_key'],
                            region_name=app.config['ATHENA_USAGE_PARAMS']['region_name'])
    table_data = glue.get_table(DatabaseName = namespace, Name = table_name)['Table']
    # update the description in the metadata of the table and prepare data to send to glue
    parameters = table_data['Parameters']
    now = datetime.datetime.now()
    comment_dict = dict([('table_description', table_description),
                         ('last_update_timestamp', now.strftime('%Y-%m-%dT%H:%M:%S'))])
    parameters['comment'] = json.dumps(comment_dict, ensure_ascii=False)
    update_dict = table_data
    keys_to_delete = ['DatabaseName', 'UpdateTime', 'IsRegisteredWithLakeFormation']
    for key in keys_to_delete:
        del (update_dict[key])
    # submit an update request to glue
    glue.update_table(DatabaseName='test', TableInput=update_dict)
    app.cache.clear()
    return index()
