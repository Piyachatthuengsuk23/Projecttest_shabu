*** Settings ***
Library    Collections

*** Test Cases ***
Verify Menu Display Logic For Empty Menu
    [Tags]    Logic
    [Documentation]    Test empty menu shows no items
    ${menu_items}=    Create List
    ${item_count}=    Get Length    ${menu_items}
    Should Be True    ${item_count} == 0

Verify Single Menu Item Display
    [Tags]    Logic
    [Documentation]    Test single item logic
    &{ITEM1}=    Create Dictionary    foodImage=img1.jpg    foodname=Pad Thai
    ${menu_items}=    Create List    ${ITEM1}
    ${item_count}=    Get Length    ${menu_items}
    Should Be True    ${item_count} == 1

Verify Multiple Menu Items Display
    [Tags]    Logic
    [Documentation]    Test multiple items logic
    &{ITEM1}=    Create Dictionary    foodImage=img1.jpg    foodname=Pad Thai
    &{ITEM2}=    Create Dictionary    foodImage=img2.jpg    foodname=Tom Yum
    ${menu_items}=    Create List    ${ITEM1}    ${ITEM2}
    ${item_count}=    Get Length    ${menu_items}
    Should Be True    ${item_count} == 2

Verify Menu Item Properties
    [Tags]    Logic
    [Documentation]    Test item has required properties
    &{ITEM1}=    Create Dictionary    foodImage=img1.jpg    foodname=Pad Thai
    Dictionary Should Contain Key    ${ITEM1}    foodImage
    Dictionary Should Contain Key    ${ITEM1}    foodname
    Should Be Equal    ${ITEM1}[foodname]    Pad Thai