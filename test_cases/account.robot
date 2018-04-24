*** Settings ***
Documentation     These are example Gherkin style test cases for
...               user account page

Library           ../scripts/mylib.py
Library           SeleniumLibrary
Resource          ../resources/resource.robot
Suite Setup       Log in to system
Suite Teardown    Close Browser

*** Test Cases ***
Change language to ru_RU
    Given user is on account page
    When user selects language "ru_RU"
        And user clicks Save
    Then inteface is in selected language    Учетная запись
        And selected language is displayed in language field    Русский

    [Teardown]    Change language to    en_US    English (US)

Email field is not editible
    Open account page
    Wait until page contains element    ${email field}
    Email field should not be editible

*** Keywords ***
User is on account page
    Open account page

Email field should not be editible
    Element should be readonly    ${email field}

User selects language "${language code}"
    Wait until page contains element    ${language dropdown}
    Click Element    ${language dropdown}
    Click Element    xpath: //span[@lang="${language code}"]

User clicks Save
    Click Button    ${save button}

Inteface is in selected language
    [Arguments]    ${language check text}
    Wait until page contains element    ${save button}
    Page should contain    ${language check text}

Selected language is displayed in language field
    [Arguments]    ${language name}
    Element should contain    ${language dropdown}    ${language name}