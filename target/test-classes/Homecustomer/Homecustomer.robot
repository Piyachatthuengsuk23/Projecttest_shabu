*** Settings ***
Library    Collections

*** Test Cases ***
Verify Navigation Links Structure
    [Tags]    Logic
    [Documentation]    Test navigation has Home, Reserve, Menu, Contact links
    @{links}=    Create List    Home    Reserve    Menu    Contact
    ${link_count}=    Get Length    ${links}
    Should Be True    ${link_count} == 4

Verify Auth Buttons Display
    [Tags]    Logic
    [Documentation]    Test Login and Register buttons exist
    @{buttons}=    Create List    Login    Register
    ${button_count}=    Get Length    ${buttons}
    Should Be True    ${button_count} == 2

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title is "Shabu Restaurant"
    ${title}=    Set Variable    Shabu Restaurant
    Should Be Equal    ${title}    Shabu Restaurant

Verify Menu Button Action
    [Tags]    Logic
    [Documentation]    Test menu button links to menu
    ${menu_link}=    Set Variable    /menu
    Should Be Equal    ${menu_link}    /menu

Verify Layout Sections
    [Tags]    Logic
    [Documentation]    Test left and right sections exist
    @{sections}=    Create List    left    right
    ${section_count}=    Get Length    ${sections}
    Should Be True    ${section_count} == 2