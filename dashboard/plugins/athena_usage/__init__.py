import boto3

from flask import current_app as app
from flask import Blueprint
from flask import render_template


from .query_dao import QueryDao
from .athena_summary_provider import AthenaSummaryProvider

base_path = '/athena_usage'
tab_name = 'Athena Usage'
plugin = Blueprint('athena_usage', __name__, template_folder='templates')


def init(app):
    dynamodb = boto3.client('dynamodb',
                            aws_access_key_id=app.config['ATHENA_USAGE_PARAMS']['aws_access_key_id'],
                            aws_secret_access_key=app.config['ATHENA_USAGE_PARAMS']['aws_secret_access_key'],
                            region_name=app.config['ATHENA_USAGE_PARAMS']['region_name'])

    app.athena_summary_provider = AthenaSummaryProvider(app.config['ATHENA_USAGE_PARAMS'], dynamodb, app.logger)


@plugin.route('/')
def index():
    summary_users_dict, summary_specials_dict = app.athena_summary_provider.summary_user_timespan_size

    # sort both summaries alphabetically
    summary_users_dict, summary_specials_dict = sorted(summary_users_dict.items()), (sorted(summary_specials_dict.items()))

    return render_template('athena_usage/index.html',
                           summary_specials_timespan_size=summary_specials_dict,
                           summary_user_timespan_size=summary_users_dict)


