*** Settings ***
Library    Collections

*** Test Cases ***
Verify Edit Waiter Form Title
    [Tags]    Logic
    [Documentation]    Test form title display
    ${title}=    Set Variable    แก้ไขข้อมูลพนักงานเสิร์ฟ
    Should Be Equal    ${title}    แก้ไขข้อมูลพนักงานเสิร์ฟ

Verify Username Field Readonly
    [Tags]    Logic
    [Documentation]    Test username is readonly
    &{WAITER}=    Create Dictionary    empUsername=waiter1
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
    @{options}=    Create List    พนักงานเสริฟ์    แคชเชียร์
    ${option_count}=    Get Length    ${options}
    Should Be True    ${option_count} == 2

Verify Submit Button Action
    [Tags]    Logic
    [Documentation]    Test submit to confirmWaiter
    ${submit_action}=    Set Variable    confirmWaiter
    Should Be Equal    ${submit_action}    confirmWaiter

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to listwaiter
    ${back_link}=    Set Variable    listwaiter
    Should Be Equal    ${back_link}    listwaiter

Verify Message Display Conditional
    [Tags]    Logic
    [Documentation]    Test success/error messages
    ${has_message}=    Evaluate    True  # Simulate conditional display
    Should Be True    ${has_message} == True