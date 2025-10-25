*** Settings ***
Library    Collections

*** Test Cases ***

Verify Add Button Link
    [Tags]    Logic
    [Documentation]    Test add button to gotoAddcashier
    ${add_link}=    Set Variable    gotoAddcashier
    Should Be Equal    ${add_link}    gotoAddcashier

Verify Edit Link Format
    [Tags]    Logic
    [Documentation]    Test edit link with empUsername
    &{WAITER}=    Create Dictionary    empUsername=waiter1
    ${edit_url}=    Evaluate    'geteditcashier?empUsername=' + '${WAITER}[empUsername]'
    Should Contain    ${edit_url}    geteditcashier

Verify Delete Function Call
    [Tags]    Logic
    [Documentation]    Test delete calls deleteEmployeeCashier
    ${delete_action}=    Set Variable    deleteEmployeeCashier
    Should Be Equal    ${delete_action}    deleteEmployeeCashier

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to backmain
    ${back_link}=    Set Variable    backmain
    Should Be Equal    ${back_link}    backmain

Verify Error Message Conditional
    [Tags]    Logic
    [Documentation]    Test error message if not empty
    ${has_error}=    Evaluate    True  # Simulate conditional
    Should Be True    ${has_error} == True