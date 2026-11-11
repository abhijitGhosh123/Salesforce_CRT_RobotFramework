*** Settings ***
Resource               commonResources.resource
Library                QForce
Library                QWeb
Library                DateTime
Library                FakerLibrary

*** Variables ***




*** Keywords ***
Create Account Record
    [Documentation]    Keyword to create an account record
    [Arguments]        ${accountName}              ${account_PhoneNumber}                 ${account_AnnualRevenue}
    ClickUntil         Account Information         New                         partial_match=False
    UseModal           On
    TypeText           Account Name                ${accountName}              anchor=Parent Account
    TypeText           Phone                       ${account_PhoneNumber}      anchor=Fax
    TypeText           Fax                         +12258443456766
    TypeText           Website                     https://www.salesforce.com
    Picklist           Type                        Prospect
    Picklist           Industry                    Finance

    TypeText           Employees                   18000
    TypeText           Annual Revenue              ${account_AnnualRevenue} billion
    ClickText          Save                        partial_match=False
    sleep              30s

    #Validating that Account record is correctly created
    ClickText          Details
    VerifyText         ${accountName}
   

Create A Contact For The Account
    [Documentation]    Keyword to create a contact for the Account
    [Arguments]        ${accountName}              ${contact_firstName}        ${contact_lastName}         ${contact_phoneNumber}      ${conatct_mobileNumber}    ${contact_email}
    ClickText          Accounts
    VerifyText         ${accountName}
    VerifyText         Contacts

    ClickUntil         Email                       Contacts
    ClickUntil         Contact Information         New                         partial_match=False
    UseModal           On
    Picklist           Salutation                  Mr.
    TypeText           First Name                  ${contact_firstName}
    TypeText           Last Name                   ${contact_lastName}
    TypeText           Phone                       ${contact_phoneNumber}      anchor=Mobile
    TypeText           Mobile                      ${conatct_mobileNumber}
    Combobox           Search Accounts...          ${accountName}              selection_delay=2

    TypeText           Email                       ${contact_email}            anchor=Reports To
    TypeText           Title                       Manager
    ClickText          Save                        partial_match=False
    Sleep              1
    ClickText          Contacts
    VerifyText         ${contact_firstName} ${contact_lastName}





Create Lead Record
    [Documentation]    Keyword to create a lead record
    [Arguments]        ${lead_firstName}           ${lead_lastName}            ${lead_companyName}         ${lead_website}             ${lead_email}
    ClickText          Leads
    VerifyText         Change Owner
    ClickText          New                         partial_match=False
    VerifyText         Lead Information
    UseModal           On                          # Only find fields from open modal dialog

    Picklist           Salutation                  Ms.
    TypeText           First Name                  ${lead_firstName}
    TypeText           Last Name                   ${lead_lastName}
    Picklist           Lead Status                 Open - Not Contacted
    # generate random phone number, just as an example
    # NOTE: initialization of random number generator is done on suite setup
    ${rand_phone}=     Generate Random String      14                          [NUMBERS]
    # concatenate leading "+" and random numbers
    ${phone}=          SetVariable                 +${rand_phone}
    TypeText           Phone                       ${phone}                    First Name
    TypeText           Company                     ${lead_companyName}         Last Name
    TypeText           Title                       Manager                     Address Information
    TypeText           Email                       ${lead_email}               Rating
    TypeText           Website                     ${lead_website}
    Picklist           Lead Source                 Partner Referral
    ClickText          Save                        partial_match=False
    UseModal           Off
    Sleep              1

    ClickText          Details
    VerifyField        Name                        Ms. ${lead_firstName} ${lead_lastName}
    VerifyField        Lead Status                 Open - Not Contacted
    VerifyField        Phone                       ${phone}
    VerifyField        Company                     ${lead_companyName}
    VerifyField        Website                     ${lead_website}


Converting A Lead To Opportunity-Account-Contact
    [Documentation]    Keyword to convert a lead to Account , Contact and Opportunity
    ClickText          Show more actions
    ClickText          Convert
    UseModal           On
    VerifyText         Convert Lead
    ClickText          Convert                     partial_match=False
    UseModal           Off
    UseModal           On
    VerifyText         Your lead has been converted
    ClickText          Go to Leads
    UseModal           Off
    ClickText          Select a List View: Leads
    ClickText          My Leads
    ClickText          Change Status
    ClickText          Close
    ClickText          Opportunities
    ClickText          Growmore-
    ClickText          Details
    VerifyText         rowmore-\nAccount Name\n\nGrowmore\nClose Date\n\n12/31/2026\nAmount
    VerifyText         Growmore-
