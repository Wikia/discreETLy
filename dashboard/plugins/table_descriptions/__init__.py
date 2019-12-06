from flask import Blueprint
from flask import render_template
from flask import current_app as app
from dashboard.utils import load_data_provider

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