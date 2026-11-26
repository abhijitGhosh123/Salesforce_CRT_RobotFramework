import os

class SalesforceConfig:
    LOGIN_URL=os.getenv("SALESFORCE_LOGIN_URL","https://urldefense.com/v3/__https://orgfarm-b8c7160cd5-dev-ed.develop.my.salesforce.com__;!!Nyu6ZXf5!spXCHb1_AxBnx7TgdLk5P869uRG7BDg2Q4wLdjb46MTPZsickjZo4eovAbxTi4Qu0lZMrUBxdA4O0nVfjW-tKA$")
    CLIENT_ID=os.getenv("SALESFORCE_CLIENT_ID")
    USERNAME=os.getenv("SALESFORCE_USERNAME")

    API_VERSION=os.getenv("SALESFORCE_API_VERSION","v65.0")