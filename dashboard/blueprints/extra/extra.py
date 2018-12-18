from datetime import datetime

from flask import Blueprint
from flask import current_app as app
from flask import render_template

import dataclasses as dc

extra = Blueprint('extra', __name__, template_folder='templates')

@extra.route('/extra')
def extra_etl():
    if app.config['EXTRA_ACTIVE']:
        return render_template('extra.html', filename='extra_etl.yaml and extra.html')
    else:
        return render_template('no_config.html', filename='extra_etl.yaml')

@extra.context_processor
def global_vars():
    return {'now': datetime.now()}

