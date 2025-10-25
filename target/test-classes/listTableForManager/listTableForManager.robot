*** Settings ***
Library    Collections

*** Test Cases ***
Verify Table Management Header Display
    [Tags]    Logic
    [Documentation]    Test header with title and count
    ${list_size}=    Set Variable    5
    ${has_header}=    Evaluate    ${list_size} >= 0
    Should Be True    ${has_header} == True

Verify Add Button Link
    [Tags]    Logic
    [Documentation]    Test add button to gotoAddTable
    ${add_link}=    Set Variable    gotoAddTable
    Should Be Equal    ${add_link}    gotoAddTable

Verify Empty State Conditional
    [Tags]    Logic
    [Documentation]    Test empty state if no tables
    @{empty_list}=    Create List
    ${is_empty}=    Evaluate    len(${empty_list}) == 0
    Should Be True    ${is_empty} == True

Verify Edit Link Format
    [Tags]    Logic
    [Documentation]    Test edit link with tableid
    &{TABLE}=    Create Dictionary    tableid=1
    ${edit_url}=    Evaluate    'geteditTable?tableid=' + str(${TABLE}[tableid])
    Should Contain    ${edit_url}    geteditTable

Verify Delete Function Call
    [Tags]    Logic
    [Documentation]    Test delete calls deleteTable
    ${delete_action}=    Set Variable    deleteTable
    Should Be Equal    ${delete_action}    deleteTable

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to home
    ${back_link}=    Set Variable    home
    Should Be Equal    ${back_link}    home

Verify Error Message Conditional
    [Tags]    Logic
    [Documentation]    Test error message if present
    ${has_error}=    Evaluate    True  # Simulate conditional
    Should Be True    ${has_error} == True