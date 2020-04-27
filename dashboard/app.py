from concurrent.futures.thread import ThreadPoolExecutor

import os
import logging
import importlib
from datetime import datetime
from typing import List

from flask import Flask, session, redirect, request, url_for
from flask_sslify import SSLify
from werkzeug.debug import DebuggedApplication
from authlib.flask.client import OAuth
from loginpass import create_flask_blueprint, Google
from werkzeug.contrib.cache import SimpleCache

from dashboard.blueprints.page import page
from dashboard.dataproviders import *
from dashboard.service.mysql import MySQLClient
from dashboard.service.influxdb_service import InfluxDbService
from dashboard.model.influxdb_data import InfluxDBData
from dashboard.model.prometheus_data import PrometheusData
from dashboard.model.tables_data import TableDataProvider
from dashboard.model.links_data import LinksDataProvider
from dashboard.models import ExtraEtl
from dashboard.utils import get_yaml_file_content

TABLES_PATH = 'config/tables.yaml'
LINKS_PATH = 'config/links.yaml'


def setup_authentication(app):
    oauth = OAuth(app)

    def handle_redirects(remote, token, user_info):
        if 'hd' in user_info:
            if user_info['hd'] == app.config['OAUTH_DOMAIN'] \
                    or (isinstance(app.config['OAUTH_DOMAIN'], List) and user_info['hd'] in app.config['OAUTH_DOMAIN']):

                session['user'] = user_info
                return redirect(session.get('next', '/'))

        return redirect(url_for('page.login'))


    def ensure_user_is_authorized(app):
        if 'user' not in session and request.path not in ['/oauth/login', '/oauth/auth', '/login', '/healthcheck'] and not request.path.startswith('/static/'):
            session['next'] = request.url
            return redirect(url_for('page.login'))

    app.register_blueprint(
        create_flask_blueprint(Google, oauth, handle_redirects),
        url_prefix='/oauth')

    app.before_request(lambda: ensure_user_is_authorized(app))


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

    plugins = {}
    for plugin in app.config['ENABLED_PLUGINS']:
        module = importlib.import_module(f'dashboard.plugins.{plugin}')
        app.register_blueprint(module.plugin, url_prefix=module.base_path)
        if hasattr(module, 'init'):
            module.init(app)
        plugins[plugin] = {'tab_name': module.tab_name}

    app.airflow_data_provider = AirflowDBDataProvider(app.config, app.logger, MySQLClient(app.config, app.logger))
    app.influx_client = InfluxDbService(app.config, app.logger) if app.config.get('INFLUXDB_HOST') else None
    app.influx_data_provider = InfluxDBData(app.influx_client, app.logger) if app.config.get('INFLUXDB_HOST') else None
    app.prometheus_data_provider = PrometheusData(app.config, app.logger) if app.config.get('PROMETHEUS_HOST') else None
    
    # Reading tables configs, setting variable to `None` if file is not present
    tables = get_yaml_file_content(TABLES_PATH)

    app.table_data_provider = TableDataProvider(
        app.airflow_data_provider, app.influx_data_provider,
        app.prometheus_data_provider, tables, app.logger, app.config) if tables else None

    links = get_yaml_file_content(LINKS_PATH)
    app.links_data_provider = LinksDataProvider(links)

    app.etl_data_provider = EtlDataProvider(
        app.config, app.airflow_data_provider, app.table_data_provider)

    app.async_request_executor = ThreadPoolExecutor(max_workers=3)
    app.cache = SimpleCache()

    if app.debug:
        app.wsgi_app = DebuggedApplication(app.wsgi_app, evalex=True)

    app.context_processor(lambda: {'now': datetime.now(), 'plugins': plugins})

    return app

if __name__ == '__main__': # non-gunicorn entry point for debugging
    create_app().run('0.0.0.0', 8000)
