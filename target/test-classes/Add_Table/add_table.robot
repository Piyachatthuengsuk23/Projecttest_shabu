*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8080/Zproject_shabu2/gotoAddTable
${BROWSER}    chrome
${TABLE_NUMBER}    T001
${CAPACITY}    4
${STATUS}    Free
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

Fill Add Table Form
    [Arguments]    ${table_number}    ${capacity}    ${status}
    Wait Until Element Is Visible    css=input#tablenumber    timeout=10s
    Input Text    css=input#tablenumber    ${table_number}
    Sleep    1s    # เพิ่ม delay หลังกรอกหมายเลขโต๊ะ
    Input Text    css=input#capacity    ${capacity}
    Sleep    1s    # เพิ่ม delay หลังกรอกความจุ
    Wait Until Element Is Visible    css=select#status    timeout=10s
    Select From List By Value    css=select#status    ${status}
    Sleep    1s    # เพิ่ม delay หลังเลือกสถานะ

*** Test Cases ***
Verify Add Table Page Loads Successfully
    Wait Until Page Contains Element    css=button.btn-primary    timeout=10s
    Page Should Contain    เพิ่มโต๊ะ
    Sleep    2s    # เพิ่ม delay เพื่อดูหน้าเพจ

Test Successful Table Addition
    Fill Add Table Form    ${TABLE_NUMBER}    ${CAPACITY}    ${STATUS}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Wait Until Element Is Enabled    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Sleep    3s    # เพิ่ม delay หลังคลิกเพื่อดูผลลัพธ์
    Wait Until Element Is Visible    css=div.success-message    timeout=10s
    Element Should Contain    css=div.success-message    ทำรายการสำเร็จ   # แก้ไขตามข้อความจริง

Test Missing Table Number
    Fill Add Table Form    ${EMPTY}    ${CAPACITY}    ${STATUS}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#tablenumber:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Capacity
    Fill Add Table Form    ${TABLE_NUMBER}    ${EMPTY}    ${STATUS}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=input#capacity:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Missing Status
    Fill Add Table Form    ${TABLE_NUMBER}    ${CAPACITY}    ${EMPTY}
    Wait Until Element Is Visible    css=button.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=button.btn-primary
    Page Should Contain Element    css=select#status:invalid
    Sleep    2s    # เพิ่ม delay เพื่อดู validation error

Test Back To Main Page Navigation
    Wait Until Element Is Visible    css=a[href='ManageTable']    timeout=10s
    Scroll Element Into View    css=a[href='ManageTable']
    Wait Until Element Is Enabled    css=a[href='ManageTable']    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิก
    Click Element    css=a[href='ManageTable']
    Wait Until Page Contains    จัดการโต๊ะ    timeout=10s    # แก้ไขตามข้อความจริง
    Sleep    2s    # เพิ่ม delay หลัง navigate เพื่อดูหน้าใหม่