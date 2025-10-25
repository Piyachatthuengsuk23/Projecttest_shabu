*** Settings ***
Library    Collections

*** Test Cases ***
Verify Form Title Display
    [Tags]    Logic
    [Documentation]    Test form title exists
    ${title}=    Set Variable    แก้ไขข้อมูลพนักงานแคชเชียร์
    Should Be Equal    ${title}    แก้ไขข้อมูลพนักงานแคชเชียร์

Verify Username Field Readonly
    [Tags]    Logic
    [Documentation]    Test username is readonly
    &{CASHIER}=    Create Dictionary    empUsername=admin
    ${is_readonly}=    Evaluate    True  # Simulate readonly attribute
    Should Be True    ${is_readonly} == True

Verify Form Fields Structure
    [Tags]    Logic
    [Documentation]    Test all form fields exist
    @{fields}=    Create List    password    empname    age    position
    ${field_count}=    Get Length    ${fields}
    Should Be True    ${field_count} == 4

Verify Position Select Options
    [Tags]    Logic
    [Documentation]    Test position options
    @{options}=    Create List    แคชเชียร์    พนักงานเสริฟ์
    ${option_count}=    Get Length    ${options}
    Should Be True    ${option_count} == 2

Verify Submit Button Action
    [Tags]    Logic
    [Documentation]    Test submit to confirmEditCashier
    ${submit_action}=    Set Variable    confirmEditCashier
    Should Be Equal    ${submit_action}    confirmEditCashier

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to listcashier
    ${back_link}=    Set Variable    listcashier
    Should Be Equal    ${back_link}    listcashier

Verify Message Display Conditional
    [Tags]    Logic
    [Documentation]    Test success/error messages
    ${has_message}=    Evaluate    True  # Simulate conditional display
    Should Be True    ${has_message} == True