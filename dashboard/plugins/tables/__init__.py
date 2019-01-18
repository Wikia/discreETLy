from flask import Blueprint
from flask import render_template
from flask import current_app as app

base_path = '/tables'
tab_name = 'Tables'
plugin = Blueprint('tables', __name__, template_folder='templates')

@plugin.route('/')
def index():
    if not app.table_data_provider:
        return render_template('no_config.html', filename='tables.yaml')

    return render_template('tables/index.html', tables=app.table_data_provider.list())


@plugin.route('/<string:table_name>')
def details(table_name):
    history = app.table_data_provider.history(table_name)
    return render_template('tables/details.html', name=table_name, counts=history)