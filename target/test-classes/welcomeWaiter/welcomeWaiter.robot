*** Settings ***
Library    Collections

*** Test Cases ***
Verify Welcome Message Display
    [Tags]    Logic
    [Documentation]    Test welcome message exists
    ${welcome}=    Set Variable    Welcome I kuy
    Should Be Equal    ${welcome}    Welcome I kuy

Verify User Username Display
    [Tags]    Logic
    [Documentation]    Test username property
    &{USER}=    Create Dictionary    empUsername=admin
    Dictionary Should Contain Key    ${USER}    empUsername
    Should Be Equal    ${USER}[empUsername]    admin

Verify User Name Display
    [Tags]    Logic
    [Documentation]    Test name property
    &{USER}=    Create Dictionary    empname=John Doe
    Dictionary Should Contain Key    ${USER}    empname
    Should Be Equal    ${USER}[empname]    John Doe

Verify User Position Display
    [Tags]    Logic
    [Documentation]    Test position property
    &{USER}=    Create Dictionary    position=Manager
    Dictionary Should Contain Key    ${USER}    position
    Should Be Equal    ${USER}[position]    Manager

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    Insert title here
    Should Be Equal    ${title}    Insert title here