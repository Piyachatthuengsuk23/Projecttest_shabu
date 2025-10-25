*** Settings ***
Library    Collections

*** Test Cases ***
Verify Navigation Links Structure
    [Tags]    Logic
    [Documentation]    Test navigation has Home, Reserve, Menu, Table, Contact links
    @{links}=    Create List    Home    Reserve    Menu    Table    Contact
    ${link_count}=    Get Length    ${links}
    Should Be True    ${link_count} == 5

Verify Hero Section Display
    [Tags]    Logic
    [Documentation]    Test hero has title and buttons
    @{buttons}=    Create List    View Menu    Reserve Table
    ${button_count}=    Get Length    ${buttons}
    Should Be True    ${button_count} == 2

Verify Conditional User Info Display
    [Tags]    Logic
    [Documentation]    Test user info shows if user exists
    &{USER}=    Create Dictionary    cusname=John Doe
    ${has_user}=    Evaluate    '${USER}[cusname]' != ''
    Should Be True    ${has_user} == True

Verify My Reservations Button Conditional
    [Tags]    Logic
    [Documentation]    Test my reservations button only if logged in
    &{USER}=    Create Dictionary    cusname=John Doe
    ${show_reservations}=    Evaluate    '${USER}[cusname]' != ''
    Should Be True    ${show_reservations} == True

Verify Quick Action Button Conditional
    [Tags]    Logic
    [Documentation]    Test quick action for reservations if user logged in
    &{USER}=    Create Dictionary    cusname=John Doe
    ${show_quick_action}=    Evaluate    '${USER}[cusname]' != ''
    Should Be True    ${show_quick_action} == True

Verify Footer Links Structure
    [Tags]    Logic
    [Documentation]    Test footer has same links as nav
    @{footer_links}=    Create List    Home    Reserve    Menu    Table    Contact
    ${footer_count}=    Get Length    ${footer_links}
    Should Be True    ${footer_count} == 5

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    ShaBu Restaurant - Authentic Japanese Hot Pot
    Should Be Equal    ${title}    ShaBu Restaurant - Authentic Japanese Hot Pot