import json

from flask import Blueprint
from flask import current_app as app
from flask import redirect, render_template, request, session, url_for

import dataclasses as dc
from dashboard.utils import clean_dag_id
from dashboard.utils.vis import tree_diagram

page = Blueprint('page', __name__, template_folder='templates')

@page.route('/')
def index():
    dags_status_future = app.async_request_executor.submit(
        app.airflow_data_provider.get_dags_status)

    template_vars = {'etl_summary': dags_status_future.result()}
    if app.table_data_provider:
        template_vars['tables'] = app.async_request_executor.submit(app.table_data_provider.list, True).result()
    
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


@page.route('/healthcheck')
def healthcheck():
    return "https://www.youtube.com/watch?v=I_izvAbhExY"


@page.errorhandler(500)
def internal_server_error(e):
    return render_template("500.html"), 200
