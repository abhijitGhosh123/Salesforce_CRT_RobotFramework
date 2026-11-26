class SalesforceClient:

    def __init__(self):
        self.access_token=None
        self.instance_url=None

    def connect(self):
        #Authentication will be implemented here
        pass

    def get_connection_status(self):
        return self.access_token  is not None
                