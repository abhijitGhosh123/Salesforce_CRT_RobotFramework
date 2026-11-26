** Settings ***
Resource                        ../resources/commonResources.resource
Library                         QForce
Library                         QWeb
Library                         DateTime
Library                         FakerLibrary
Suite Setup                     Setup Browser
Suite Teardown                  End suite


*** Test Cases ***
TC_DataTable_E2E_Account,Contact,Lead & Opportunity Creation in Salesforce
    [Documentation]             TC to login into SF and create an account & Contact
    [Tags]                      E2ESFautomation
    Login                       ${login_url}                ${username}                 ${password}
    VerifyText                  Developer Edition
    LaunchApp                   Sales
    ClickText                   Accounts


    #TC01_Creating an account record and validating whether account record is being created successfully or not
    Run Keyword And Continue On Failure                     Create Account Record       ${dt_E2E_SalesforceFlow_Abhijit.Account Name}           ${dt_E2E_SalesforceFlow_Abhijit.Account PhoneNumber}    ${dt_E2E_SalesforceFlow_Abhijit.Account AnnualRevenue}
    ${accountID}=               Get Record ID From Url
    Log To Console              ${accountID}


    #TC02_Creating a contact record and validating that contact record is being created successfully .
    Run Keyword And Continue On Failure                     Create A Contact For The Account                        ${dt_E2E_SalesforceFlow_Abhijit.Account Name}           ${dt_E2E_SalesforceFlow_Abhijit.Conatct FirstName}      ${dt_E2E_SalesforceFlow_Abhijit.Conatct LastName}    ${dt_E2E_SalesforceFlow_Abhijit.Contact PhoneNumber}    ${dt_E2E_SalesforceFlow_Abhijit.Contact MobileNumber}    ${dt_E2E_SalesforceFlow_Abhijit.Conatct Email}

    #TC03_Creating a lead record and validating whether lead record is being created successfully or not
    Run Keyword And Continue On Failure                     Create Lead Record          ${dt_E2E_SalesforceFlow_Abhijit.Lead FirstName}         ${dt_E2E_SalesforceFlow_Abhijit.Lead LastName}          ${dt_E2E_SalesforceFlow_Abhijit.Lead CompanyNumber}    ${dt_E2E_SalesforceFlow_Abhijit.Lead Website}    ${dt_E2E_SalesforceFlow_Abhijit.Lead Email}

    #TC04_Converting a lead to Opportunity , Contact & Account
    Run Keyword And Continue On Failure                     Converting A Lead To Opportunity-Account-Contact        ${dt_E2E_SalesforceFlow_Abhijit.Lead CompanyNumber}
