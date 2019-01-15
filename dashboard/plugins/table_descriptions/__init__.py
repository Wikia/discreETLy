from flask import Blueprint
from flask import render_template
from flask import current_app as app
from dashboard.utils import load_data_provider

base_path = '/table_descriptions'
tab_name = 'Table descriptions'
plugin = Blueprint('table_descriptions', __name__, template_folder='templates')

def get_descriptions(cache_ttl=300):
    descriptions = app.cache.get('table_descriptions')
    if descriptions is not None:
        return descriptions

    classname = app.config['TABLE_DESCRIPTION_SERVICE']
    params = app.config['TABLE_DESCRIPTION_SERVICE_PARAMS']
    params['logger'] = app.logger
    params['config'] = app.config
    params['tables'] = app.table_data_provider.tables

    descriptions = load_data_provider(classname, params).get_table_descriptions()
    app.cache.set('table_descriptions', descriptions, timeout=cache_ttl)
    return descriptions

@plugin.route('/')
def index():
    if not 'TABLE_DESCRIPTION_SERVICE' in app.config:
        return render_template('no_config.html', filename='TABLE_DESCRIPTION_SERVICE')

    return render_template('table_descriptions/index.html', tables=get_descriptions())