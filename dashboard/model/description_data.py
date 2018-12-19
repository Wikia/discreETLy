

class DescriptionData:
    def __init__(self, config, logger, tables):
        self.logger = logger
        service_class = config.get('COLUMN_DESCRIPTION_SERVICE')
        if not service_class:
            raise Exception('COLUMN_DESCRIPTION_SERVICE not set')

        try:
            module_name, class_name = service_class.rsplit('.', 1)
            module = __import__(module_name)
            class_ = getattr(module, class_name)
            self.description_service = class_(tables, config)
        except Exception as e:
            raise Exception(f'Could not instantiatie the provided COLUMN_DESCRIPTION_SERVICE: {service_class}') from e

    def tables(self):
        return self.description_service.get_table_descriptions()
