*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/gotoAddMenu
${BROWSER}    chrome
${FOOD_NAME}    ชาบูหมู
${PRICE}    299
${IMAGE_URL}    https://example.com/food.jpg
${FOOD_TYPE}    ชาบู
${EMPTY}    ${EMPTY}

*** Keywords ***
Open Browser With Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gcm
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Sleep    2s    # เพิ่ม delay หลังเปิดเบราว์เซอร์

Fill Add Menu Form
    [Arguments]    ${food_name}    ${price}    ${image_url}    ${food_type}
    Wait Until Element Is Visible    css=input#foodname    timeout=10s
    Input Text    css=input#foodname    ${food_name}
    Sleep    1s    # เพิ่ม delay หลังกรอกชื่ออาหาร
    Input Text    css=input#price    ${price}
    Sleep    1s    # เพิ่ม delay หลังกรอกราคา
    Input Text    css=input#url    ${image_url}
    Sleep    1s    # เพิ่ม delay หลังกรอก URL รูปภาพ
    Wait Until Element Is Visible    css=select#type    timeout=10s
    Select From List By Value    css=select#type    ${food_type}
    Sleep    1s    # เพิ่ม delay หลังเลือกประเภทอาหาร

*** Test Cases ***
Verify Add Menu Page Loads Successfully
    Wait Until Page Contains Element    css=button.btn-primary    timeout=10s
    Page Should Contain    เพิ่มเมนูอาหาร
    Sleep    2s    # เพิ่ม delay เพื่อดูหน้าเพจ

Test Successful Menu Addition
    Fill Add Menu Form    ${FOOD_NAME}    ${PRICE}    ${IMAGE_URL}    ${FOOD_TYPE}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Wait Until Element Is Enabled    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Sleep    3s    # เพิ่ม delay หลังคลิกเพื่อดูผลลัพธ์
    Wait Until Element Is Visible    css=div.success-message    timeout=10s
    Element Should Contain    css=div.success-message    ทำรายการสำเร็จ    # แก้ไขตามข้อความจริง

Test Missing Food Name
    Fill Add Menu Form    ${EMPTY}    ${PRICE}    ${IMAGE_URL}    ${FOOD_TYPE}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#foodname:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Price
    Fill Add Menu Form    ${FOOD_NAME}    ${EMPTY}    ${IMAGE_URL}    ${FOOD_TYPE}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#price:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Image URL
    Fill Add Menu Form    ${FOOD_NAME}    ${PRICE}    ${EMPTY}    ${FOOD_TYPE}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#url:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Back To Main Page Navigation
    # Scroll down the page to ensure the back link is in view
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight / 2);
    Sleep    1s
    Wait Until Element Is Visible    css=a[href='ListAllMenuFood']    timeout=10s
    Scroll Element Into View    css=a[href='ListAllMenuFood']
    Wait Until Element Is Enabled    css=a[href='ListAllMenuFood']    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิก
    Click Element    css=a[href='ListAllMenuFood']
    Wait Until Page Contains    รายการเมนูอาหาร    timeout=10s    # แก้ไขตามข้อความจริง
    Sleep    2s    # เพิ่ม delay หลัง navigate เพื่อดูหน้าใหม่