from concurrent.futures.thread import ThreadPoolExecutor

import yaml
import os
import logging

from flask import Flask, session, redirect
from flask_sslify import SSLify
from werkzeug.debug import DebuggedApplication
from authlib.flask.client import OAuth
from loginpass import create_flask_blueprint, Google

from dashboard.blueprints.page import page
from dashboard.blueprints.extra import extra
from dashboard.dataproviders import *
from dashboard.service.mysql import MySQLClient
from dashboard.model.influxdb_data import InfluxDBData
from dashboard.model.prometheus_data import PrometheusData
from dashboard.model.tables_data import TableDataProvider
from dashboard.model.reports_data import ReportsDataProvider
from dashboard.models import ExtraEtl


TABLES_PATH = '../config/tables.yaml'
EXTRA_ETL_PATH = '../config/extra_etl.yaml'
REPORTS_PATH = '../config/reports.yaml'


def get_yaml_file_content(path):
    config_file = os.path.join(os.path.dirname(os.path.realpath(__file__)), path)
    if os.path.exists(config_file):
        with open(config_file, 'r') as file:
            return yaml.load(file)
    else:
        return None


def setup_authentication(app):
    oauth = OAuth(app)

    def handle_authorize(remote, token, user_info):
        if not 'hd' in user_info or user_info['hd'] != app.config['OAUTH_DOMAIN']:
            return redirect('/login')

        session['user'] = user_info
        return redirect(session.get('next', '/'))

    app.register_blueprint(
        create_flask_blueprint(Google, oauth, handle_authorize),
        url_prefix='/oauth')


def create_app(settings_override=None):
    """
    Create a Flask application using the app factory pattern.
    :param settings_override: Override settings
    :return: Flask app
    """
    app = Flask(__name__, instance_relative_config=True)

    def disable_varnish(response):
        response.cache_control.private = True
        return response
    app.after_request(disable_varnish)

    SSLify(app, skips=['healthcheck'])
    gunicorn_logger = logging.getLogger('gunicorn.error')
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level)

    app.config.from_object('config.settings')

    if 'GOOGLE_CLIENT_ID' in app.config:
        setup_authentication(app)

    app.register_blueprint(page)
    app.register_blueprint(extra)

    app.airflow_data_provider = AirflowDBDataProvider(app.config, app.logger, MySQLClient(app.config, app.logger))
    app.influx_data_provider = InfluxDBData(app.config, app.logger) if app.config.get('INFLUXDB_HOST') else None
    app.prometheus_data_provider = PrometheusData(app.config, app.logger) if app.config.get('PROMETHEUS_HOST') else None
    
    # Reading all external configs, setting variables to `None` if files are not present
    tables = get_yaml_file_content(TABLES_PATH)
    reports = get_yaml_file_content(REPORTS_PATH)
    extra_etls_file = get_yaml_file_content(EXTRA_ETL_PATH)
    extra_etls = [ExtraEtl(**etl) for etl in extra_etls_file] if extra_etls_file else None

    app.table_data_provider = TableDataProvider(
        app.airflow_data_provider, app.influx_data_provider, app.prometheus_data_provider, tables, app.logger) if tables else None

    app.etl_data_provider = EtlDataProvider(
        app.config, extra_etls, app.airflow_data_provider, app.table_data_provider)

    app.description_data_provider = DescriptionData(
        app.config, app.logger, tables) if app.config.get('COLUMN_DESCRIPTION_ACTIVE') else None

    app.report_data_provider = ReportsDataProvider(
        app.airflow_data_provider, reports['reports']
    ) if reports else None

    app.async_request_executor = ThreadPoolExecutor(max_workers=3)

    if app.debug:
        app.wsgi_app = DebuggedApplication(app.wsgi_app, evalex=True)

    return app

if __name__ == '__main__': # non-gunicorn entry point for debugging
    create_app().run('0.0.0.0', 8000)
