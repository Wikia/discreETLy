

class LinksDataProvider:
    def __init__(self, links):
        self.links = links if links else []

    def get_links(self):
        return self.links
