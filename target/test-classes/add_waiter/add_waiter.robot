*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/gotoAddwaiter
${BROWSER}    chrome
${EMP_USERNAME}    waiter001
${PASSWORD}    Pass1234
${EMP_NAME}    สมชาย ใจดี
${AGE}    25
${POSITION}    พนักงานเสิร์ฟ    # ปรับเป็นค่า value จริง เช่น "waiter" หากหน้าเว็บใช้ value
${IMAGE_URL}    https://example.com/waiter.jpg
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

Fill Add Waiter Form
    [Arguments]    ${emp_username}    ${password}    ${emp_name}    ${age}    ${position}    ${image_url}
    Wait Until Element Is Visible    css=input#empusername    timeout=10s
    Input Text    css=input#empusername    ${emp_username}
    Sleep    1s    # เพิ่ม delay หลังกรอก username
    Input Text    css=input#password    ${password}
    Sleep    1s    # เพิ่ม delay หลังกรอก password
    Input Text    css=input#empname    ${emp_name}
    Sleep    1s    # เพิ่ม delay หลังกรอกชื่อพนักงาน
    Input Text    css=input#age    ${age}
    Sleep    1s    # เพิ่ม delay หลังกรอกอายุ
    Wait Until Element Is Visible    css=select#position    timeout=10s
    ${options}=    Get List Items    css=select#position    values=True
    Log    Available options in position dropdown: ${options}
    Run Keyword And Ignore Error    Select From List By Label    css=select#position    ${position}
    Run Keyword If    '${position}' not in @{options}    Select From List By Value    css=select#position    ${position}
    Sleep    1s    # เพิ่ม delay หลังเลือกตำแหน่ง
    Input Text    css=input#url    ${image_url}
    Sleep    1s    # เพิ่ม delay หลังกรอก URL รูปภาพ

Scroll To Submit Button
    Scroll Element Into View    css=button.btn-primary
    Sleep    1s    # เพิ่ม delay หลังเลื่อนไปยังปุ่ม

*** Test Cases ***
Verify Add Waiter Page Loads Successfully
    Wait Until Page Contains Element    css=button.btn-primary    timeout=10s
    Page Should Contain    เพิ่มพนักงานเสิร์ฟ
    Sleep    2s    # เพิ่ม delay เพื่อดูหน้าเพจ

Test Successful Waiter Addition
    Fill Add Waiter Form    ${EMP_USERNAME}    ${PASSWORD}    ${EMP_NAME}    ${AGE}    ${POSITION}    ${IMAGE_URL}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Wait Until Element Is Enabled    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Sleep    3s    # เพิ่ม delay หลังคลิกเพื่อดูผลลัพธ์

Test Missing Username
    Fill Add Waiter Form    ${EMPTY}    ${PASSWORD}    ${EMP_NAME}    ${AGE}    ${POSITION}    ${IMAGE_URL}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#empusername:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Password
    Fill Add Waiter Form    ${EMP_USERNAME}    ${EMPTY}    ${EMP_NAME}    ${AGE}    ${POSITION}    ${IMAGE_URL}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#password:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Employee Name
    Fill Add Waiter Form    ${EMP_USERNAME}    ${PASSWORD}    ${EMPTY}    ${AGE}    ${POSITION}    ${IMAGE_URL}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#empname:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Age
    Fill Add Waiter Form    ${EMP_USERNAME}    ${PASSWORD}    ${EMP_NAME}    ${EMPTY}    ${POSITION}    ${IMAGE_URL}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#age:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Image URL
    Fill Add Waiter Form    ${EMP_USERNAME}    ${PASSWORD}    ${EMP_NAME}    ${AGE}    ${POSITION}    ${EMPTY}
    Scroll To Submit Button
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#url:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Back To Main Page Navigation
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    1s
    Wait Until Element Is Visible    css=a[href='backmain']    timeout=10s
    Scroll Element Into View    css=a[href='backmain']
    Wait Until Element Is Enabled    css=a[href='backmain']    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิก
    Click Element    css=a[href='backmain']
    Wait Until Page Contains    หน้าหลัก    timeout=10s    # แก้ไขตามข้อความจริง
    Sleep    2s    # เพิ่ม delay หลัง navigate เพื่อดูหน้าใหม่