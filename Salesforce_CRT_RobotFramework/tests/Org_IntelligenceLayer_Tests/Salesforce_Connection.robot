*** Settings ***
Library               ../../libraries/Org_IntelligenceLayer/salesforce_client.py

*** Test Cases ***
Verify Salesforce Client
    ${result}=        Connect
    Log               ${result}

    ${status}=        Get Connection Status
    Should Be True    ${status}
