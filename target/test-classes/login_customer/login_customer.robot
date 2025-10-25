*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/gotologin
${BROWSER}    chrome
${USERNAME}    y-cai1
${PASSWORD}    apri12012

*** Keywords ***
Open Browser With Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gcm
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window

Fill Login Form
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    css=input[name='cususername']    timeout=10s
    Input Text    css=input[name='cususername']    ${username}
    Input Text    css=input[name='cuspassword']    ${password}

*** Test Cases ***
Verify Login Page Loads Successfully
    Wait Until Page Contains Element    css=button.btn-login    timeout=10s
    Page Should Contain    เข้าสู่ระบบลูกค้า

Test Successful Login
    Fill Login Form    ${USERNAME}    ${PASSWORD}
    Wait Until Element Is Visible    css=button.btn-login    timeout=10s
    Wait Until Element Is Enabled    css=button.btn-login    timeout=10s
    Click Button    css=button.btn-login

Test Missing Username
    Fill Login Form    ${EMPTY}    ${PASSWORD}
    Wait Until Element Is Visible    css=button.btn-login    timeout=10s
    Click Button    css=button.btn-login
    Page Should Contain Element    css=input[name='cususername']:invalid

Test Missing Password
    Fill Login Form    ${USERNAME}    ${EMPTY}
    Wait Until Element Is Visible    css=button.btn-login    timeout=10s
    Click Button    css=button.btn-login
    Page Should Contain Element    css=input[name='cuspassword']:invalid


Test Register Link Navigation
    Wait Until Element Is Visible    css=a[href='regiscus']    timeout=10s
    Scroll Element Into View    css=a[href='regiscus']
    Wait Until Element Is Enabled    css=a[href='regiscus']    timeout=10s
    Click Element    css=a[href='regiscus']
    Wait Until Page Contains    ลงทะเบียนลูกค้า    timeout=10s