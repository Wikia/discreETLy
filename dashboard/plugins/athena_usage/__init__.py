from flask import Blueprint
from flask import render_template

base_path = '/athena_usage'
tab_name = 'Athena Usage Dashboard!'
plugin = Blueprint('athena_usage', __name__, template_folder='templates')

@plugin.route('/')
def index():
    return render_template('athena_usage/index.html')
