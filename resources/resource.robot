*** Settings ***
Documentation     A resource file with reusable keywords and variables.
Library           ../scripts/mylib.py
Library           SeleniumLibrary

*** Variables ***
${base url}             https://beta.nxvms.com
${account url}          ${base url}/account
${browser}              Chrome
${delay}                0

# User data
${email}                noptixqa+admin@gmail.com
${new email}            noptixqa+admin-new@gmail.com
${password}             qweasd123

# Element locators
${logo}                 class:lead
${email field}          xpath: //input[@ng-model="account.email"]
${language dropdown}    xpath: //form[@name="accountForm"]//language-select
${save button}          xpath: //process-button[@process="save"]//button
${login form}           css:form[name="loginForm"]
${login link}           default:/login
${login button}         xpath: //process-button[@process="login"]//button

*** Keywords ***
Log in to system
    Open browser to main page
    Click Link    default:/login
    Fill Login form
    Wait Until Page Does Not Contain Element    css:input[type=email]

Fill Login form
    Wait until page contains element    ${login button}
    Enter email    ${email}
    Enter password    ${password}
    Click Button    ${login button}

Enter email
    [Arguments]    ${email}
    Input Text    css:input[type=email]    ${email}

Enter password
    [Arguments]    ${password}
    Input Text    css:input[type=password]    ${password}

Open browser to main page
	Open browser    ${base url}    ${browser}
	Maximize browser window
	Set Selenium speed    ${delay}
	Wait Until Page Contains Element    ${logo}
	Main page should be open

Open account page
	Go to    ${account url}

Open browser to account page
	Open browser    ${account url}    ${browser}
	Maximize browser window
	Set Selenium speed    ${delay}
	Account page should be open

Change language to
    [Arguments]    ${language code}    ${language name}
    User is on account page
    User selects language "${language code}"
    User clicks Save
    Selected language is displayed in language field    ${language name}

Account page should be open
	Title should be    Account

Main page should be open
	Page should contain element    class:cloud-icon

Log in again if logout has happen occasionaly
    ${present}  Run keyword and return status    Page should contain     Log in to Nx Cloud
    Run keyword if    ${present}    Fill login form

