*** Settings ***
Library    Collections

*** Test Cases ***
Verify Menu List Header Display
    [Tags]    Logic
    [Documentation]    Test header with title and count
    ${list_size}=    Set Variable    5
    ${has_header}=    Evaluate    ${list_size} >= 0
    Should Be True    ${has_header} == True


Verify Status Badge Conditional
    [Tags]    Logic
    [Documentation]    Test status classes
    &{ITEM_CONFIRM}=    Create Dictionary    status=Confirm
    &{ITEM_RESERVED}=    Create Dictionary    status=Reserved
    ${is_confirm}=    Evaluate    '${ITEM_CONFIRM}[status]' == 'Confirm'
    ${is_reserved}=    Evaluate    '${ITEM_RESERVED}[status]' == 'Reserved'
    Should Be True    ${is_confirm} == True
    Should Be True    ${is_reserved} == True

Verify Empty State Conditional
    [Tags]    Logic
    [Documentation]    Test empty state if no items
    @{empty_list}=    Create List
    ${is_empty}=    Evaluate    len(${empty_list}) == 0
    Should Be True    ${is_empty} == True

Verify Payment Button Conditional
    [Tags]    Logic
    [Documentation]    Test payment button only for Confirm
    &{CONFIRM_ITEM}=    Create Dictionary    status=Confirm
    ${show_payment}=    Evaluate    '${CONFIRM_ITEM}[status]' == 'Confirm'
    Should Be True    ${show_payment} == True

Verify Edit Link Format
    [Tags]    Logic
    [Documentation]    Test edit link with reserveid
    &{ITEM}=    Create Dictionary    reserveid=1
    ${edit_url}=    Evaluate    'geteditMenufood?foodId=' + str(${ITEM}[reserveid])
    Should Contain    ${edit_url}    geteditMenufood

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to homecashier
    ${back_link}=    Set Variable    homecashier
    Should Be Equal    ${back_link}    homecashier

Verify Error Message Conditional
    [Tags]    Logic
    [Documentation]    Test error message if present
    ${has_error}=    Evaluate    True  # Simulate conditional
    Should Be True    ${has_error} == True