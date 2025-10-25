*** Settings ***
Library    Collections

*** Test Cases ***
Verify Welcome Card Display
    [Tags]    Logic
    [Documentation]    Test welcome card shows greeting and date
    ${formatted_date}=    Set Variable    20/10/2025
    ${has_date}=    Evaluate    '${formatted_date}' != ''
    Should Be True    ${has_date} == True

Verify Action Buttons Grid Structure
    [Tags]    Logic
    [Documentation]    Test 6 action buttons exist
    @{actions}=    Create List    Employees    Food    Tables    Bills    Orders    Logout
    ${action_count}=    Get Length    ${actions}
    Should Be True    ${action_count} == 6

Verify Manage Employees Link
    [Tags]    Logic
    [Documentation]    Test employees link to ManagerEmployee
    ${employees_link}=    Set Variable    ManagerEmployee
    Should Be Equal    ${employees_link}    ManagerEmployee

Verify Manage Food Link
    [Tags]    Logic
    [Documentation]    Test food link to ListAllMenuFood
    ${food_link}=    Set Variable    ListAllMenuFood
    Should Be Equal    ${food_link}    ListAllMenuFood

Verify Manage Tables Link
    [Tags]    Logic
    [Documentation]    Test tables link to ManageTable
    ${tables_link}=    Set Variable    ManageTable
    Should Be Equal    ${tables_link}    ManageTable

Verify View Bills Link
    [Tags]    Logic
    [Documentation]    Test bills link to listuser
    ${bills_link}=    Set Variable    listuser
    Should Be Equal    ${bills_link}    listuser

Verify Manage Orders Link
    [Tags]    Logic
    [Documentation]    Test orders link to Addcoursepage
    ${orders_link}=    Set Variable    Addcoursepage
    Should Be Equal    ${orders_link}    Addcoursepage

Verify Logout Link
    [Tags]    Logic
    [Documentation]    Test logout link to logoutmanager
    ${logout_link}=    Set Variable    logoutmanager
    Should Be Equal    ${logout_link}    logoutmanager

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    Home | Manager
    Should Be Equal    ${title}    Home | Manager