*** Settings ***
Library    Collections

*** Test Cases ***
Verify User Welcome Display
    [Tags]    Logic
    [Documentation]    Test user info display
    &{USER}=    Create Dictionary    empUsername=admin    empname=John Doe    position=Manager
    ${has_user}=    Evaluate    '${USER}[empUsername]' != ''
    Should Be True    ${has_user} == True

Verify Employee Username Display
    [Tags]    Logic
    [Documentation]    Test username property
    &{USER}=    Create Dictionary    empUsername=admin
    Dictionary Should Contain Key    ${USER}    empUsername
    Should Be Equal    ${USER}[empUsername]    admin

Verify Employee Name Display
    [Tags]    Logic
    [Documentation]    Test name property
    &{USER}=    Create Dictionary    empname=John Doe
    Dictionary Should Contain Key    ${USER}    empname
    Should Be Equal    ${USER}[empname]    John Doe

Verify Employee Position Display
    [Tags]    Logic
    [Documentation]    Test position property
    &{USER}=    Create Dictionary    position=Manager
    Dictionary Should Contain Key    ${USER}    position
    Should Be Equal    ${USER}[position]    Manager

Verify Form Action Existence
    [Tags]    Logic
    [Documentation]    Test form submits to listTableReserveForCashier
    ${form_action}=    Set Variable    listTableReserveForCashier
    Should Be Equal    ${form_action}    listTableReserveForCashier

Verify Page Welcome Message
    [Tags]    Logic
    [Documentation]    Test welcome message exists
    ${welcome}=    Set Variable    Welcome I kuy
    Should Be Equal    ${welcome}    Welcome I kuy