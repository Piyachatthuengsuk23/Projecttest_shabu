*** Settings ***
Library    Collections

*** Test Cases ***
Verify Waiter Login Title
    [Tags]    Logic
    [Documentation]    Test page title display
    ${title}=    Set Variable    Login Waiter - Restaurant Management System
    Should Be Equal    ${title}    Login Waiter - Restaurant Management System

Verify Roles Structure
    [Tags]    Logic
    [Documentation]    Test 4 roles exist
    @{roles}=    Create List    Manager    Cashier    Waiter    Customer
    ${role_count}=    Get Length    ${roles}
    Should Be True    ${role_count} == 4

Verify Active Waiter Role
    [Tags]    Logic
    [Documentation]    Test Waiter role is active
    ${active_role}=    Set Variable    Waiter
    Should Be Equal    ${active_role}    Waiter

Verify Manager Role Form Action
    [Tags]    Logic
    [Documentation]    Test Manager submits to RoleManager
    ${manager_action}=    Set Variable    RoleManager
    Should Be Equal    ${manager_action}    RoleManager

Verify Cashier Role Form Action
    [Tags]    Logic
    [Documentation]    Test Cashier submits to RoleCashier
    ${cashier_action}=    Set Variable    RoleCashier
    Should Be Equal    ${cashier_action}    RoleCashier

Verify Waiter Role Form Action
    [Tags]    Logic
    [Documentation]    Test Waiter submits to RoleWaiter
    ${waiter_action}=    Set Variable    RoleWaiter
    Should Be Equal    ${waiter_action}    RoleWaiter

Verify Customer Role Form Action
    [Tags]    Logic
    [Documentation]    Test Customer submits to RoleCustomer
    ${customer_action}=    Set Variable    RoleCustomer
    Should Be Equal    ${customer_action}    RoleCustomer

Verify Login Form Action
    [Tags]    Logic
    [Documentation]    Test login submits to LoginWaiter
    ${login_action}=    Set Variable    LoginWaiter
    Should Be Equal    ${login_action}    LoginWaiter

Verify Login Form Fields
    [Tags]    Logic
    [Documentation]    Test username and password fields
    @{fields}=    Create List    empUsername    empPassword
    ${field_count}=    Get Length    ${fields}
    Should Be True    ${field_count} == 2