*** Settings ***
Resource                     ../resources/common.robot
Library                      QForce
Library                      QWeb
Library                      DateTime
Library                      FakerLibrary
Suite Setup                  Setup Browser
Suite Teardown               End suite


*** Test Cases ***

TC01_Account&Contact Creation in Salesforce
    [Documentation]          TC to login into SF and create an account & Contact
    [Tags]                   SFAutomation
    Login                    ${login_url}                ${username}                 ${password}
    VerifyText               Developer Edition
    LaunchApp                Sales
    ClickText                Accounts

    #Creating Account record
    ClickUntil               Account Information         New                         partial_match=False
    UseModal                 On
    ${randomAccountName}=    FakerLibrary.Company
    ${accountName}=          Catenate                    SEPARATOR=__                Copado                   ${randomAccountName}
    Set Suite Variable       ${accountName}
    ${date} =                Get Current Date            UTC
    TypeText                 Account Name                ${accountName}              anchor=Parent Account
    TypeText                 Phone                       +12258443456789             anchor=Fax
    TypeText                 Fax                         +12258443456766
    TypeText                 Website                     https://www.salesforce.com
    Picklist                 Type                        Prospect
    Picklist                 Industry                    Finance

    TypeText                 Employees                   35000
    TypeText                 Annual Revenue              12 billion
    ClickText                Save                        partial_match=False
    sleep                    30s
    ${accountID}=            Get Record ID From Url
    Set Suite Variable       ${accountID}
    Log To Console           ${accountID}

    #Validating that Account record is correctly created
    ClickText                Details
    VerifyText               ${accountName}
    VerifyText               35,000

    # Create A Contact For The Account

    ClickText                Accounts
    VerifyText               ${accountName}
    VerifyText               Contacts

    ClickUntil               Email                       Contacts
    ClickUntil               Contact Information         New                         partial_match=False
    UseModal                 On
    Picklist                 Salutation                  Mr.
    ${firstName}=            FakerLibrary.First Name
    ${lastName}=             FakerLibrary.Last Name
    TypeText                 First Name                  ${firstName}
    TypeText                 Last Name                   ${lastName}
    TypeText                 Phone                       +00150345678134             anchor=Mobile
    TypeText                 Mobile                      +00150345678178
    Combobox                 Search Accounts...          Salesforce                  selection_delay=2

    TypeText                 Email                       richard.brown@gmail.com     anchor=Reports To
    TypeText                 Title                       Manager
    ClickText                Save                        partial_match=False
    Sleep                    1
    ClickText                Contacts
    VerifyText               ${firstName} ${lastName}
    Set Suite Variable       ${ContactName}              ${firstName} ${lastName}
    
    #Creating Lead record
    
