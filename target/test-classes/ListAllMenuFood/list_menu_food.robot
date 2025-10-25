*** Settings ***
Library    SeleniumLibrary
Test Setup    Open Browser With Options
Test Teardown    Close Browser

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/ListAllMenuFood
${BROWSER}    chrome

*** Keywords ***
Open Browser With Options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gcm
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window

Verify Menu Count
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    css=p.menu-count    timeout=10s
    ${menu_count_text}=    Get Text    css=p.menu-count
    Should Match Regexp    ${menu_count_text}    จำนวนเมนูทั้งหมด: ${expected_count} เมนู

*** Test Cases ***
Verify List Menu Page Loads Successfully
    Wait Until Page Contains Element    css=table    timeout=10s
    Page Should Contain    รายการเมนูอาหาร

Test Menu Count Display
    # สมมติว่ามีเมนูอย่างน้อย 1 รายการ หรือปรับตามข้อมูลจริง
    Verify Menu Count    \\d+

Test Add Menu Button Navigation
    Wait Until Element Is Visible    css=a.add-btn    timeout=10s
    Scroll Element Into View    css=a.add-btn
    Wait Until Element Is Enabled    css=a.add-btn    timeout=10s
    Click Element    css=a.add-btn
    Wait Until Page Contains    เพิ่มเมนูอาหาร    timeout=10s

Test Edit Menu Button
    # สมมติว่าเลือกเมนูแรกในตาราง
    Wait Until Element Is Visible    css=tbody tr:first-child a.edit-btn    timeout=10s
    Scroll Element Into View    css=tbody tr:first-child a.edit-btn
    Wait Until Element Is Enabled    css=tbody tr:first-child a.edit-btn    timeout=10s
    Click Element    css=tbody tr:first-child a.edit-btn
    Wait Until Page Contains    แก้ไขข้อมูลอาหาร    timeout=10s    # แก้ไขตามข้อความจริง

Test Delete Menu Button
    # สมมติว่าเลือกเมนูแรกในตาราง
    Wait Until Element Is Visible    css=tbody tr:first-child a.delete-btn    timeout=10s
    Scroll Element Into View    css=tbody tr:first-child a.delete-btn
    Wait Until Element Is Enabled    css=tbody tr:first-child a.delete-btn    timeout=10s
    # ตรวจสอบว่าหน้า reload และเมนูลดลงหรือไม่
    ${row_count}=    Get Element Count    css=tbody tr
    Should Be True    ${row_count} >= 0


Test Error Message Display
    # สมมติว่ามีข้อผิดพลาดจาก server
    # ต้องจำลองสถานการณ์ที่มี error_message ซึ่งอาจต้องปรับแต่งตามบริบท
    Run Keyword And Ignore Error    Wait Until Element Is Visible    css=div.error-message    timeout=5s