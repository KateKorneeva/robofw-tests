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

    # Change language back
    [Teardown]    Change language to    en_US    English (US)

Email field is not editible
    Open account page
    Wait until page contains element    ${email field}
    Email field should not be editible

Change first name
    Given user is on account page
    When user edits first-name field
        And user clicks Save
    Then new name is displayed in first-name field
        And new name is displayed on system page

#	Scenario outline: Change first or last name
#		Given user is on account page
#		When user edits <name field>
#			And user clicks Save
#		Then page is refreshed
#			And new name is displayed in the field
#			And new name is displayed on system page
#
#		Examples:
#
#		|   name field   |
#		| first name     |
#		| last name      |
#
#	Scenario: Change all fields
#		Given user is on account page
#		When user changes fields with first name and last name
#			And user selects another language
#			And user clicks Save
#		Then page is refreshed
#			And inteface now is in selected language
#			And new values are displayed in all changed fields


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

User edits ${field} field
    pass execution

New ${text} is displayed in ${field} field
    pass execution

New ${text} is displayed on system page