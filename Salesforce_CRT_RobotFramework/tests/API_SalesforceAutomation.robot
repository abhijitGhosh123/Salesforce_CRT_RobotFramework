*** Settings ***
Resource                        ../resources/commonResources.resource
Library                         QForce
Library                         QWeb
Library                         DateTime
Library                         FakerLibrary
Suite Setup                     Setup Browser
Suite Teardown                  End suite


*** Test Cases ***

TC_E2E_Account,Contact,Lead & Opportunity Creation in Salesforce
    [Documentation]             TC to login into SF and create an account & Contact
    [Tags]                      E2ESFautomation
    Login                       ${login_url}                ${username}            ${password}
    VerifyText                  Developer Edition
    LaunchApp                   Sales
    ClickText                   Accounts

    #Creating Account record
    ${randomAccountName}=       FakerLibrary.Company
    ${accountName}=             Catenate                    SEPARATOR=__           Copado                    ${randomAccountName}
    ${account_PhoneNumber}=     FakerLibrary.Phone Number
    ${account_AnnualRevenue}=                               FakerLibrary.Random Number                       digits=9

    #TC01_Creating an account record and validating whether account record is being created successfully or not
    Run Keyword And Continue On Failure                     Create Account Record                            ${accountName}              ${account_PhoneNumber}    ${account_AnnualRevenue}
    ${accountID}=               Get Record ID From Url
    Log To Console              ${accountID}

    # Create A Contact For The Account
    ${contact_firstName}=       FakerLibrary.First Name
    ${contact_lastName}=        FakerLibrary.Last Name
    ${contact_phoneNumber}=     FakerLibrary.Phone Number
    ${conatct_mobileNumber}=    FakerLibrary.Phone Number
    ${contact_email}=           FakerLibrary.Email

    #TC02_Creating a contact record and validating that contact record is being created successfully .
    Run Keyword And Continue On Failure                     Create A Contact For The Account                 ${accountName}              ${contact_firstName}      ${contact_lastName}        ${contact_phoneNumber}    ${conatct_mobileNumber}    ${contact_email}

    #Creating Lead record
    ${lead_firstName}=          FakerLibrary.First Name
    ${lead_lastName}=           FakerLibrary.Last Name
    ${lead_companyName}=        FakerLibrary.Company
    ${lead_phoneNumber}=        FakerLibrary.Phone Number
    ${lead_website}=            FakerLibrary.Url
    ${lead_email}=              FakerLibrary.Email

    #TC03_Creating a lead record and validating whether lead record is being created successfully or not
    Run Keyword And Continue On Failure                     Create Lead Record     ${lead_firstName}         ${lead_lastName}            ${lead_companyName}       ${lead_website}            ${lead_email}

    #TC04_Converting a lead to Opportunity , Contact & Account
    Run Keyword And Continue On Failure                     Converting A Lead To Opportunity-Account-Contact                             ${lead_companyName}

External Client App Login Example - Appstate
    [Tags]                      ConnectedApp                ExternalClientApp      JWT                       JWTtoken
    [Documentation]             A short example of how to use the JWT/External Client App to log into an environment.
    Appstate                    JwtAuthenticate             ${client_id}           ${persona_username}       ${server_key}
    JwtLogin                    /lightning/o/Account/list
    QForce.ClickText            New