*** Settings ***
Documentation     Check changing landuage works for all languages

Library           SeleniumLibrary
Resource          ../resources/resource.robot
Suite Teardown    Run keywords    Log in to system
...               AND             Change language   en_US   Account   English (US)
...               AND             Close Browser
Test Setup        Log in to system
Test Teardown     Close Browser
Test Template     Change Language

*** Test Cases ***       LANGUAGE CODE       CHECK TEXT       LANGUAGE NAME
To Russian               ru_RU               Учетная запись   Русский
To French                fr_FR               Compte           Français
To German                de_DE               Account          Deutsch
To Spanish               es_ES               Cuenta           Español
To English (US)          en_US               Account          English (US)



*** Keywords ***
Change language
    [Arguments]    ${language code}   ${check text}    ${language name}
    Given user is on account page
    When user selects language ${language code}
        And user clicks Save
    Then inteface is in selected language    ${check text}
        And selected language is displayed in language field    ${language name}
