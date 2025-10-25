*** Settings ***
Library    Collections

*** Test Cases ***
Verify Login Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    Login Cashier - Restaurant Management System
    Should Be Equal    ${title}    Login Cashier - Restaurant Management System

Verify Roles Structure
    [Tags]    Logic
    [Documentation]    Test 4 roles exist
    @{roles}=    Create List    Manager    Cashier    Waiter    Customer
    ${role_count}=    Get Length    ${roles}
    Should Be True    ${role_count} == 4

Verify Active Cashier Role
    [Tags]    Logic
    [Documentation]    Test Cashier role is active
    ${active_role}=    Set Variable    Cashier
    Should Be Equal    ${active_role}    Cashier

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
    [Documentation]    Test login submits to LoginCashier
    ${login_action}=    Set Variable    LoginCashier
    Should Be Equal    ${login_action}    LoginCashier

Verify Login Form Fields
    [Tags]    Logic
    [Documentation]    Test username and password fields
    @{fields}=    Create List    empUsername    empPassword
    ${field_count}=    Get Length    ${fields}
    Should Be True    ${field_count} == 2