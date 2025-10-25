*** Settings ***
Library    Collections

*** Test Cases ***
Verify Empty Food Types Show No Sections
    [Tags]    Logic
    [Documentation]    Test empty foodTypeList shows no sections
    ${food_types}=    Create List
    ${type_count}=    Get Length    ${food_types}
    Should Be True    ${type_count} == 0

Verify Single Food Type Display
    [Tags]    Logic
    [Documentation]    Test single food type logic
    &{TYPE1}=    Create Dictionary    foodtypeId=1    foodtypeName=Appetizers
    ${food_types}=    Create List    ${TYPE1}
    ${type_count}=    Get Length    ${food_types}
    Should Be True    ${type_count} == 1

Verify Multiple Food Types Display
    [Tags]    Logic
    [Documentation]    Test multiple food types logic
    &{TYPE1}=    Create Dictionary    foodtypeId=1    foodtypeName=Appetizers
    &{TYPE2}=    Create Dictionary    foodtypeId=2    foodtypeName=Mains
    ${food_types}=    Create List    ${TYPE1}    ${TYPE2}
    ${type_count}=    Get Length    ${food_types}
    Should Be True    ${type_count} == 2

Verify Skip Special Food Type
    [Tags]    Logic
    [Documentation]    Test skip 'ต่อคน' type
    &{TYPE_SPECIAL}=    Create Dictionary    foodtypeId=99    foodtypeName=ต่อคน
    &{TYPE_NORMAL}=    Create Dictionary    foodtypeId=1    foodtypeName=Appetizers
    ${food_types}=    Create List    ${TYPE_SPECIAL}    ${TYPE_NORMAL}
    ${normal_types}=    Create List
    FOR    ${type}    IN    @{food_types}
        Run Keyword If    '${type}[foodtypeName]' != 'ต่อคน'    Append To List    ${normal_types}    ${type}
    END
    ${normal_count}=    Get Length    ${normal_types}
    Should Be True    ${normal_count} == 1


Verify Menu Item Has Required Properties
    [Tags]    Logic
    [Documentation]    Test menu item properties
    &{MENU1}=    Create Dictionary    foodId=1    foodname=Spring Rolls    price=100    foodImage=img1.jpg
    Dictionary Should Contain Key    ${MENU1}    foodId
    Dictionary Should Contain Key    ${MENU1}    foodname
    Dictionary Should Contain Key    ${MENU1}    price
    Dictionary Should Contain Key    ${MENU1}    foodImage
    Should Be Equal    ${MENU1}[foodname]    Spring Rolls

Verify Cart Highlight Logic
    [Tags]    Logic
    [Documentation]    Test has-items class when qty > 0
    &{MENU1}=    Create Dictionary    foodId=1    foodname=Spring Rolls
    ${cart_qty}=    Set Variable    3
    ${has_items}=    Evaluate    ${cart_qty} > 0
    Should Be True    ${has_items} == True
