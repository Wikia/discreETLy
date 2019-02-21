import boto3

from flask import current_app as app
from flask import Blueprint
from flask import render_template


from .query_dao import QueryDao

base_path = '/athena_usage'
tab_name = 'Athena Usage Dashboard!'
plugin = Blueprint('athena_usage', __name__, template_folder='templates')


def init(app):
    # sqs = boto3.client('sqs')
    boto3.client('athena',
                 aws_access_key_id=app.config['ATHENA_USAGE_PARAMS']['aws_access_key_id'],
                 aws_secret_access_key=app.config['ATHENA_USAGE_PARAMS']['aws_secret_access_key'],
                 region_name=app.config['ATHENA_USAGE_PARAMS']['region_name'])
    dynamodb = boto3.resource('dynamodb', region_name=app.config['ATHENA_USAGE_PARAMS']['region_name'])

    app.query_dao = QueryDao(app.config['ATHENA_USAGE_PARAMS'], dynamodb)

@plugin.route('/')
def index():
    return render_template('athena_usage/index.html', query_result = str(app.query_dao.get_running_queries()))


