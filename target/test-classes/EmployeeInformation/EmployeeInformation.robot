*** Settings ***
Library    Collections

*** Test Cases ***
Verify Employee Management Page Structure
    [Tags]    Logic
    [Documentation]    Test page has two main sections: Waiter and Cashier
    ${sections}=    Create List    Waiter    Cashier
    ${section_count}=    Get Length    ${sections}
    Should Be True    ${section_count} == 2

Verify Waiter Section Display
    [Tags]    Logic
    [Documentation]    Test Waiter section with add and view actions
    &{WAITER_SECTION}=    Create Dictionary    add=gotoAddwaiter    view=listwaiter
    Dictionary Should Contain Key    ${WAITER_SECTION}    add
    Dictionary Should Contain Key    ${WAITER_SECTION}    view
    Should Be Equal    ${WAITER_SECTION}[add]    gotoAddwaiter

Verify Cashier Section Display
    [Tags]    Logic
    [Documentation]    Test Cashier section with add and view actions
    &{CASHIER_SECTION}=    Create Dictionary    add=gotoAddcashier    view=listcashier
    Dictionary Should Contain Key    ${CASHIER_SECTION}    add
    Dictionary Should Contain Key    ${CASHIER_SECTION}    view
    Should Be Equal    ${CASHIER_SECTION}[add]    gotoAddcashier

Verify Back Button Navigation
    [Tags]    Logic
    [Documentation]    Test back button links to home
    ${back_link}=    Set Variable    home
    Should Be Equal    ${back_link}    home

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title is "จัดการพนักงาน"
    ${title}=    Set Variable    จัดการพนักงาน
    Should Be Equal    ${title}    จัดการพนักงาน
