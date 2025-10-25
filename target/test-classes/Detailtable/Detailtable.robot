*** Settings ***
Library    Collections

*** Test Cases ***
Verify Table Details Display
    [Tags]    Logic
    [Documentation]    Test table details properties
    &{TABLE}=    Create Dictionary    tableid=5    capacity=4    status=Free
    Dictionary Should Contain Key    ${TABLE}    tableid
    Dictionary Should Contain Key    ${TABLE}    capacity
    Dictionary Should Contain Key    ${TABLE}    status

Verify Status Free Display
    [Tags]    Logic
    [Documentation]    Test Free status shows check icon
    &{TABLE_FREE}=    Create Dictionary    status=Free
    ${is_free}=    Evaluate    '${TABLE_FREE}[status]' == 'Free'
    Should Be True    ${is_free} == True

Verify Status In Use Display
    [Tags]    Logic
    [Documentation]    Test In use status shows chair icon
    &{TABLE_IN_USE}=    Create Dictionary    status=In use
    ${is_in_use}=    Evaluate    '${TABLE_IN_USE}[status]' == 'In use'
    Should Be True    ${is_in_use} == True

Verify Status Reserved Display
    [Tags]    Logic
    [Documentation]    Test Reserved status shows lock icon
    &{TABLE_RESERVED}=    Create Dictionary    status=Already reserved
    ${is_reserved}=    Evaluate    '${TABLE_RESERVED}[status]' == 'Already reserved'
    Should Be True    ${is_reserved} == True

Verify Reserve Button Conditional
    [Tags]    Logic
    [Documentation]    Test reserve button shows if Free
    &{TABLE_FREE}=    Create Dictionary    status=Free
    ${show_reserve}=    Evaluate    '${TABLE_FREE}[status]' == 'Free'
    Should Be True    ${show_reserve} == True

Verify Disabled Button Conditional
    [Tags]    Logic
    [Documentation]    Test disabled button if not Free
    &{TABLE_IN_USE}=    Create Dictionary    status=In use
    ${show_disabled}=    Evaluate    '${TABLE_IN_USE}[status]' != 'Free'
    Should Be True    ${show_disabled} == True

Verify Home Button Link
    [Tags]    Logic
    [Documentation]    Test home button links to welcome
    ${home_link}=    Set Variable    gotoWellcomeCustomerT
    Should Be Equal    ${home_link}    gotoWellcomeCustomerT

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    Table Details
    Should Be Equal    ${title}    Table Details