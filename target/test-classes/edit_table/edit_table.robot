*** Settings ***
Library    SeleniumLibrary
Documentation    Test suite for editing table information
Test Setup    Open Browser To Edit Table Page
Test Teardown    Close Browser

*** Variables ***
${BROWSER}    chrome
${URL}        http://localhost:8082/Zproject_shabu2/geteditTable?tableid=T001
${CAPACITY}   6
${STATUS}     In use

*** Keywords ***
Open Browser To Edit Table Page
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    modules=sys
    Call Method    ${options}    add_argument    --disable-notifications
    Call Method    ${options}    add_argument    --disable-gcm
    Open Browser    ${URL}    ${BROWSER}    options=${options}
    Maximize Browser Window
    Set Selenium Implicit Wait    10s
    Sleep    2s    # เพิ่ม delay หลังเปิดเบราว์เซอร์
    Wait Until Page Contains Element    css=.form-container    timeout=10s

Input Table Details
    [Arguments]    ${capacity}    ${status}
    Wait Until Element Is Visible    id=capacity    timeout=10s
    Input Text    id=capacity    ${capacity}
    Sleep    1s    # เพิ่ม delay หลังกรอก capacity
    Select From List By Value    id=status    ${status}
    Sleep    1s    # เพิ่ม delay หลังเลือก status

Submit Table Form
    Wait Until Element Is Visible    css=.btn-primary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม
    Click Button    css=.btn-primary
    Sleep    3s    # เพิ่ม delay หลัง submit เพื่อดูผลลัพธ์

Reset Table Form
    Wait Until Element Is Visible    css=.btn-secondary    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิกปุ่ม reset
    Click Button    css=.btn-secondary
    Sleep    2s    # เพิ่ม delay หลัง reset
    ${table_value}=    Get Value    id=tableid
    Should Be Equal    ${table_value}    T001
    ${cap_value}=    Get Value    id=capacity
    Should Be Equal    ${cap_value}    4
    ${status_value}=    Get Selected List Value    id=status
    Should Be Equal    ${status_value}    Free

Verify Form Elements Present
    Element Should Be Visible    id=tableid
    Element Should Be Visible    id=capacity
    Element Should Be Visible    id=status
    Element Should Be Visible    css=.btn-primary
    Element Should Be Visible    css=.btn-secondary
    Element Should Be Visible    css=.form-links a
    Sleep    2s    # เพิ่ม delay เพื่อดูหน้าเพจ


*** Test Cases ***
TC01 - Verify Form Elements Are Present
    [Documentation]    Test that all form elements are displayed
    Verify Form Elements Present

TC02 - Successful Table Edit
    [Documentation]    Test form submission with valid table details
    Input Table Details    ${CAPACITY}    ${STATUS}
    Submit Table Form

TC06 - Verify Back Link Redirects
    [Documentation]    Test that back link redirects to ManageTable page
    Wait Until Element Is Visible    css=.form-links a    timeout=10s
    Sleep    1s    # เพิ่ม delay ก่อนคลิก
    Click Link    css=.form-links a
    Sleep    2s    # เพิ่ม delay หลัง navigate
    Wait Until Location Contains    ManageTable    timeout=10s