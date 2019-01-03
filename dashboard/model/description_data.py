

class DescriptionData:
    def __init__(self, config, logger, tables):
        self.logger = logger
        service_class = config.get('TABLE_DESCRIPTION_SERVICE')
        if not service_class:
            raise Exception('TABLE_DESCRIPTION_SERVICE not set')

        try:
            parts = service_class.split('.')
            module = __import__('.'.join(parts[:-1]))
            for comp in parts[1:]:
                module = getattr(module, comp)
            self.description_service = module(logger, config, tables)
        except Exception as e:
            raise Exception(f'Could not instantiate the provided TABLE_DESCRIPTION_SERVICE: {service_class}') from e

    def tables(self):
        return self.description_service.get_table_descriptions()
