from flask import Blueprint
from flask import render_template

base_path = '/hello_world'
tab_name = 'Hello World!'
plugin = Blueprint('hello_world', __name__, template_folder='templates')

@plugin.route('/')
def index():
    return render_template('hello_world/index.html')