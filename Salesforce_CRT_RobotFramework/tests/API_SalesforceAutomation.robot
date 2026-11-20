*** Settings ***
Resource                        ../resources/commonResources.resource
Library                         QForce
Library                         QWeb
Library                         DateTime
Library                         FakerLibrary
Suite Setup                     Setup Browser
Suite Teardown                  End suite


*** Test Cases ***
External Client App Login Example - Appstate
    [Tags]                      ConnectedApp                ExternalClientApp      JWT                       JWTtoken
    [Documentation]             A short example of how to use the JWT/External Client App to log into an environment.
    Appstate                    JwtAuthenticate             ${client_id}           ${persona_username}       ${server_key}
    JwtLogin                    /lightning/o/Account/list
    QForce.ClickText            New