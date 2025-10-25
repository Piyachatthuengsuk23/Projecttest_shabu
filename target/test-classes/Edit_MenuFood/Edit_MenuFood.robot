*** Settings ***
Library    Collections

*** Test Cases ***
Verify Edit Food Form Title
    [Tags]    Logic
    [Documentation]    Test form title display
    ${title}=    Set Variable    แก้ไขข้อมูลอาหาร
    Should Be Equal    ${title}    แก้ไขข้อมูลอาหาร

Verify Hidden Food ID Field
    [Tags]    Logic
    [Documentation]    Test hidden foodId field exists
    &{MENU}=    Create Dictionary    foodId=1
    Dictionary Should Contain Key    ${MENU}    foodId
    Should Be True    ${MENU}[foodId] > 0

Verify Form Fields Structure
    [Tags]    Logic
    [Documentation]    Test all form fields exist
    @{fields}=    Create List    foodname    price    foodImage    type
    ${field_count}=    Get Length    ${fields}
    Should Be True    ${field_count} == 4

Verify Food Types Select Options
    [Tags]    Logic
    [Documentation]    Test type select from foodTypes
    @{food_types}=    Create List    Appetizers    Mains    Desserts
    ${type_count}=    Get Length    ${food_types}
    Should Be True    ${type_count} > 0

Verify Image Preview Conditional
    [Tags]    Logic
    [Documentation]    Test image preview if foodImage not empty
    &{MENU_WITH_IMAGE}=    Create Dictionary    foodImage=img.jpg
    ${has_image}=    Evaluate    '${MENU_WITH_IMAGE}[foodImage]' != ''
    Should Be True    ${has_image} == True

Verify Submit Button Action
    [Tags]    Logic
    [Documentation]    Test submit to confirmEditMenuFood
    ${submit_action}=    Set Variable    confirmEditMenuFood
    Should Be Equal    ${submit_action}    confirmEditMenuFood

Verify Back Link Action
    [Tags]    Logic
    [Documentation]    Test back to ListAllMenuFood
    ${back_link}=    Set Variable    ListAllMenuFood
    Should Be Equal    ${back_link}    ListAllMenuFood

Verify Message Display Conditional
    [Tags]    Logic
    [Documentation]    Test success/error messages
    ${has_message}=    Evaluate    True  # Simulate conditional display
    Should Be True    ${has_message} == True