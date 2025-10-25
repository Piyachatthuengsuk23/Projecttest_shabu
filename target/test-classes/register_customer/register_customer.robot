*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/regiscus
${BROWSER}    chrome
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

Fill Registration Form
    [Arguments]    ${username}    ${password}    ${name}    ${phone}    ${age}    ${email}
    Wait Until Element Is Visible    css=input#username    timeout=10s
    Input Text    css=input#username    ${username}
    Sleep    1s    # เพิ่ม delay หลังกรอก username
    Input Text    css=input#password    ${password}
    Sleep    1s    # เพิ่ม delay หลังกรอก password
    Input Text    css=input#name    ${name}
    Sleep    1s    # เพิ่ม delay หลังกรอกชื่อ
    Input Text    css=input#phonenumber    ${phone}
    Sleep    1s    # เพิ่ม delay หลังกรอกเบอร์โทร
    Input Text    css=input#age    ${age}
    Sleep    1s    # เพิ่ม delay หลังกรอกอายุ
    Input Text    css=input#email    ${email}
    Sleep    1s    # เพิ่ม delay หลังกรอกอีเมล
    # เลื่อนลงเพื่อให้ปุ่ม submit อยู่ในมุมมอง
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight);
    Sleep    1s

*** Test Cases ***
Verify Registration Page Loads Successfully
    Wait Until Page Contains Element    css=button.btn-primary-modern    timeout=10s
    Page Should Contain    ลงทะเบียนลูกค้า
    Sleep    2s    # เพิ่ม delay เพื่อดูหน้าเพจ

Test Successful Form Submission
    Fill Registration Form    testuser    Password123    Test Name    0812345678    25    test@example.com
    Wait Until Element Is Visible    css=button.btn-primary-modern    timeout=10s
    Wait Until Element Is Enabled    css=button.btn-primary-modern    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary-modern
    Sleep    3s    # เพิ่ม delay หลังคลิกเพื่อดูผลลัพธ์
    # เพิ่มการตรวจสอบผลลัพธ์ เช่น เปลี่ยนหน้าไปยังหน้าอื่น หรือมีข้อความยืนยัน

Test Missing Required Fields
    Fill Registration Form    ${EMPTY}    Password123    Test Name    0812345678    25    test@example.com
    Wait Until Element Is Visible    css=button.btn-primary-modern    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary-modern
    Page Should Contain Element    css=input#username:invalid    # ตรวจสอบว่า input มีสถานะ invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Invalid Email Format
    Fill Registration Form    testuser    Password123    Test Name    0812345678    25    invalid-email
    Wait Until Element Is Visible    css=button.btn-primary-modern    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary-modern
    Page Should Contain Element    css=input#email:invalid    # ตรวจสอบว่า input email มีสถานะ invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Login Link Navigation
    # Scroll down the page to ensure the login link is in view
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight / 2);
    Sleep    1s
    Wait Until Element Is Visible    css=a[href='gotologin']    timeout=10s
    Scroll Element Into View    css=a[href='gotologin']
    Wait Until Element Is Enabled    css=a[href='gotologin']    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิก
    Click Element    css=a[href='gotologin']
    Sleep    2s    # เพิ่ม delay หลัง navigate เพื่อดูหน้าใหม่
    Wait Until Page Contains    เข้าสู่ระบบ    timeout=10s    # ตรวจสอบว่าหน้า login โหลดสำเร็จ