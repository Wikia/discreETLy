import re
import os
import yaml
import time

def clean_dag_id(dag_id):
    return re.sub('_v?[0-9]+.[0-9]+$', '', dag_id)


def handle_resource(resource, value = None):
    def check_optional(func):
        def func_wrapper(self, *args, **kwargs):
            return func(self, *args, **kwargs) if self.__dict__.get(resource) else value
        return func_wrapper
    return check_optional

def simple_state(state):
    if state in ('success', 'failed'):
        return state
    else: # simplifies statuses like "queued", "up_for_retry", etc
        return 'running'

def load_data_provider(classname, params):
    try:
        parts = classname.split('.')
        module = __import__('.'.join(parts[:-1]))
        for comp in parts[1:]:
            module = getattr(module, comp)
        return module(**params)
    except Exception as e:
        raise Exception(f'Could not instantiate the provided TABLE_DESCRIPTION_SERVICE: {classname}', e)

def get_yaml_file_content(path):
    config_file = path
    if os.path.exists(config_file):
        with open(config_file, 'r') as file:
            return yaml.load(file)
    else:
        return None

# source: https://stackoverflow.com/a/1094933/7098262
def sizeof_fmt(num, suffix='B'):
    for unit in ['','Ki','Mi','Gi','Ti','Pi','Ei','Zi']:
        if abs(num) < 1024.0:
            return "%3.1f%s%s" % (num, unit, suffix)
        num /= 1024.0
    return "%.1f%s%s" % (num, 'Yi', suffix)


class Timer:

    def __init__(self, logger, description):
        self.logger = logger
        self.description = description

    def __enter__(self):
        self.start = time.time()
        self.logger.debug(f"{self.description} started")
        return self

    def __exit__(self, *args):
        self.interval = time.time() - self.start
        self.logger.info(f"{self.description} took {self.interval:.2f} sec")