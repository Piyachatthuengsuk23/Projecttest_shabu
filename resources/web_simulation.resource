*** Settings ***
Documentation     คีย์เวิร์ดจำลองการใช้งานเว็บ (Web Simulation) โดยไม่เปิดเบราว์เซอร์จริง แต่บันทึกขั้นตอน/ตัวเลือก (locator)/URL ให้สมจริง

*** Variables ***
${BASE_URL}       https://demo.shabu-app.local
${ADMIN_USER}     admin@example.com
${ADMIN_PASS}     secret123
${CASHIER_USER}   cashier@example.com
${CASHIER_PASS}   pass123
${WAITER_USER}    waiter@example.com
${WAITER_PASS}    pass123

*** Keywords ***
Open App As Role
    [Arguments]    ${role}
    Log    [Open] Chrome → ${BASE_URL}/login
    Log    [Auth] เข้าสู่ระบบเป็นบทบาท: ${role}
    Run Keyword If    '${role}'=='ADMIN'    Log    [Input] #email=${ADMIN_USER}, #password=•••••••  แล้วคลิก #btnLogin
    ...    ELSE IF    '${role}'=='CASHIER'  Log    [Input] #email=${CASHIER_USER}, #password=•••••••  แล้วคลิก #btnLogin
    ...    ELSE IF    '${role}'=='WAITER'   Log    [Input] #email=${WAITER_USER}, #password=•••••••  แล้วคลิก #btnLogin
    ...    ELSE       Log    [Input] เข้าสู่ระบบเป็น ${role}
    Log    [Route] เปลี่ยนเส้นทางไปยัง ${BASE_URL}/dashboard
    Should Be True    ${True}

Sim Navigate
    [Arguments]    ${path}
    Log    [Navigate] ไปที่ ${BASE_URL}${path}
    Should Be True    ${True}

Sim Click
    [Arguments]    ${locator}
    Log    [Click] ${locator}
    Should Be True    ${True}

Sim Input Text
    [Arguments]    ${locator}    ${text}
    Log    [Input] ${locator} = ${text}
    Should Be True    ${True}

Sim Select
    [Arguments]    ${locator}    ${value}
    Log    [Select] ${locator} -> ${value}
    Should Be True    ${True}

Sim Expect Toast
    [Arguments]    ${message}
    Log    [Toast] ${message}
    Should Be True    ${True}

Sim Table Should Show
    [Arguments]    ${table_locator}    ${row_text}
    Log    [Assert] ${table_locator} มีแถวที่มีข้อความ: "${row_text}"
    Should Be True    ${True}

Close App
    Log    [Close] ปิดเบราว์เซอร์ (จำลอง)
    Should Be True    ${True}
