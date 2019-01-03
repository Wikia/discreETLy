import json
from datetime import datetime

from flask import Blueprint
from flask import current_app as app
from flask import redirect, render_template, request, session, url_for

import dataclasses as dc
from dashboard.utils import clean_dag_id
from dashboard.utils.vis import tree_diagram

page = Blueprint('page', __name__, template_folder='templates')


def oauth_login_required():
    if 'user' not in session and request.path not in ['/login', '/healthcheck']:
        session['next'] = request.url
        return redirect(url_for('page.login'))
    elif 'user' not in session and 'GOOGLE_CLIENT_ID' not in app.config:
        session['user'] = { 'picture': 'https://www.gravatar.com/avatar/94d093eda664addd6e450d7e9881bcad?s=32&d=identicon&r=PG'}
        return

page.before_request(oauth_login_required)

@page.route('/')
def index():
    dags_status_future = app.async_request_executor.submit(
        app.airflow_data_provider.get_dags_status)

    template_vars = {'etl_summary': dags_status_future.result()}
    if app.table_data_provider:
        template_vars['tables'] = app.async_request_executor.submit(app.table_data_provider.list, False).result()
    
    return render_template('index.html', **template_vars)


@page.route('/login')
def login():
    if 'GOOGLE_CLIENT_ID' in app.config:
        return render_template('login.html')
    else:
        return redirect(url_for('page.index'))


@page.route('/logout')
def logout():
    del session['user']
    return redirect(url_for('page.index'))


@page.route('/etl')
def etl_dashboard():
    etl_with_progress_future = app.async_request_executor.submit(
        app.etl_data_provider.etl_with_progress)
    history_future = app.async_request_executor.submit(
        app.airflow_data_provider.get_history, 14)

    return render_template('etl_dashboard.html',
                           etls=etl_with_progress_future.result(),
                           history=history_future.result())


@page.route('/etl/<string:dag_id>/<string:execution_date>')
def etl_details(dag_id, execution_date):
    name_without_version = clean_dag_id(dag_id)
    data = app.table_data_provider.get_tables_graph(dag_id, execution_date)
    return render_template('etl_details.html', name=name_without_version, data=data, raw=json.dumps(
        tree_diagram([{
            'id': v.id,
            'name': v.name,
            'success': v.get_graph_color(),
            'parent': v.parent} for v in data], width=800, height=800, padding=8)
    ))


@page.route('/tables')
def tables_dashboard():
    if app.table_data_provider:
        tables = app.table_data_provider.list()
        return render_template('table_dashboard.html', tables=tables)
    else:
        return render_template('no_config.html', filename='tables.yaml')


@page.route('/tables/<string:table_name>')
def table_graph(table_name):
    history = app.table_data_provider.history(table_name)
    return render_template('table.html', name=table_name, counts=history)


@page.route('/reports')
def reports_dashboard():
    if app.report_data_provider:
        return render_template('reports.html',
                            reports=app.report_data_provider.reports
                            )
    else:
        return render_template('no_config.html', filename='reports.yaml')


@page.route('/descriptions')
def extra_dashboard():
    if app.config['TABLE_DESCRIPTION_ACTIVE']:
        return render_template('descriptions.html', tables=app.description_data_provider.tables())
    else:
        return render_template('no_config.html', filename='TABLE_DESCRIPTION_SERVICE')


@page.app_template_filter()
def describe_seconds(seconds):
    m, s = divmod(int(seconds), 60)
    h, m = divmod(m, 60)
    result = "{}s".format(s)
    if m > 0:
        result = "{}m {}".format(m, result)
    if h > 0:
        result = "{}h {}".format(h, result)
    return result


@page.context_processor
def global_vars():
    return {'now': datetime.now()}


@page.route('/healthcheck')
def healthcheck():
    return "https://www.youtube.com/watch?v=I_izvAbhExY"


@page.errorhandler(500)
def internal_server_error(e):
    return render_template("500.html"), 200
