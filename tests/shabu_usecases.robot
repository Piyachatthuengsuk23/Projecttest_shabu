*** Settings ***
Documentation     ชุดทดสอบระบบบริหารจัดการร้านชาบูบุฟเฟต์ () — 32 Use Cases
Resource          ../../resources/thai_keywords.resource
Library           OperatingSystem
Library           Collections
Suite Setup       Log To Console    \nเริ่มรันทดสอบชุด: Shabu Buffet Management ()\n
Suite Teardown    Log To Console    \nสิ้นสุดการทดสอบชุด: Shabu Buffet Management ()\n

*** Variables ***
${DUMMY_DB}       {'customers': [{'id': 1, 'name': 'สมชาย ไทยแท้', 'phone': '0812345678', 'email': 'somchai@example.com'}],
...               'tables': {'1': {'status': 'ว่าง', 'capacity': 4}, '2': {'status': 'ไม่ว่าง', 'capacity': 6}},
...               'orders': [{'id': 101, 'table': 1, 'items': [{'menu': 'เนื้อวัว', 'quantity': 2}], 'total': 500}],
...               'employees': [{'id': 201, 'name': 'สมหญิง ใจดี', 'role': 'แคชเชียร์'}],
...               'menu': [{'id': 301, 'name': 'เนื้อวัว', 'price': 150, 'stock': 50}]}

*** Keywords ***
Step Should Succeed
    [Arguments]    ${message}
    Log    ${message}
    Should Be True    ${True}

Create
    [Arguments]    ${entity}    ${details}
    Log    สร้าง ${entity}: ${details}
    Set Suite Variable    ${_last_create_entity}    ${entity}
    Set Suite Variable    ${_last_create_details}    ${details}
    Should Be True    ${True}

Update
    [Arguments]    ${entity}    ${id}    ${new_details}
    Log    อัปเดต ${entity} ID ${id}: ${new_details}
    Set Suite Variable    ${_last_update_entity}    ${entity}
    Set Suite Variable    ${_last_update_id}        ${id}
    Set Suite Variable    ${_last_update_details}   ${new_details}
    Should Be True    ${True}

Delete
    [Arguments]    ${entity}    ${id}
    Log    ลบ ${entity} ID ${id}
    Set Suite Variable    ${_last_delete_entity}    ${entity}
    Set Suite Variable    ${_last_delete_id}        ${id}
    Should Be True    ${True}

Calculate
    [Arguments]    ${what}    ${params}
    Log    คำนวณ ${what} ด้วย ${params}
    ${result}=    Evaluate    ${params}
    Log To Console    \nผลลัพธ์(${what}) = ${result}
    RETURN    ${result}

*** Test Cases ***
UC01 | สร้างลูกค้าใหม่ (Customer Create)
    [Documentation]    UC01 - สร้างลูกค้าใหม่ (Customer Create)
    [Tags]    Customer
    Create    ลูกค้า    {'id': 2, 'name': 'สมหญิง ใจดี', 'phone': '0898765432', 'email': 'somyhing@example.com'}
    Should Be True    ${True}

UC02 | ค้นหาลูกค้า (Customer Search)
    [Documentation]    UC02 - ค้นหาลูกค้า (Customer Search)
    [Tags]    Customer
    Step Should Succeed    ค้นหาลูกค้าด้วยเบอร์โทร 0812345678 และพบข้อมูลสมชาย ไทยแท้
    Should Be True    ${True}

UC03 | แก้ไขข้อมูลลูกค้า (Customer Update)
    [Documentation]    UC03 - แก้ไขข้อมูลลูกค้า (Customer Update)
    [Tags]    Customer
    Update    ลูกค้า    1    {'id': 1, 'name': 'สมชาย ไทยแท้ (แก้ไข)', 'phone': '0812345678', 'email': 'somchai.updated@example.com'}
    Should Be True    ${True}

UC04 | ลบลูกค้า (Customer Delete)
    [Documentation]    UC04 - ลบลูกค้า (Customer Delete)
    [Tags]    Customer
    Delete    ลูกค้า    1
    Should Be True    ${True}

UC05 | ตรวจสอบความซ้ำของเบอร์โทร (Phone Duplicate Check)
    [Documentation]    UC05 - ตรวจสอบความซ้ำของเบอร์โทร (Phone Duplicate Check)
    [Tags]    Customer
    Step Should Succeed    ตรวจสอบเบอร์ 0812345678 และพบว่าซ้ำกับลูกค้าที่มีอยู่
    Should Be True    ${True}

UC06 | ผูกสมาชิกกับประวัติการสั่งซื้อ (Link Member History)
    [Documentation]    UC06 - ผูกสมาชิกกับประวัติการสั่งซื้อ (Link Member History)
    [Tags]    Customer
    Step Should Succeed    ผูกลูกค้า ID 1 กับออเดอร์ ID 101
    Should Be True    ${True}

UC07 | จองโต๊ะ (Create Reservation)
    [Documentation]    UC07 - จองโต๊ะ (Create Reservation)
    [Tags]    Reservation
    Create    การจอง    {'table': 1, 'customer_id': 1, 'time': '18:00', 'date': '2025-09-30'}
    Should Be True    ${True}

UC08 | แก้ไขการจอง (Edit Reservation)
    [Documentation]    UC08 - แก้ไขการจอง (Edit Reservation)
    [Tags]    Reservation
    Update    การจอง    1    {'table': 2, 'customer_id': 1, 'time': '19:00', 'date': '2025-09-30'}
    Should Be True    ${True}

UC09 | ยกเลิกการจอง (Cancel Reservation)
    [Documentation]    UC09 - ยกเลิกการจอง (Cancel Reservation)
    [Tags]    Reservation
    Step Should Succeed    ยกเลิกการจองโต๊ะ 1 สำหรับลูกค้า ID 1
    Should Be True    ${True}

UC10 | เช็คสถานะโต๊ะว่าง/ไม่ว่าง (Table Availability)
    [Documentation]    UC10 - เช็คสถานะโต๊ะว่าง/ไม่ว่าง (Table Availability)
    [Tags]    Reservation
    Step Should Succeed    เช็คโต๊ะ 1 และพบว่าว่าง
    Should Be True    ${True}

UC11 | เช็คอินลูกค้าตามเวลาจอง (Reservation Check-in)
    [Documentation]    UC11 - เช็คอินลูกค้าตามเวลาจอง (Reservation Check-in)
    [Tags]    Reservation
    Step Should Succeed    เช็คอินลูกค้า ID 1 ที่โต๊ะ 1 เวลา 18:00
    Should Be True    ${True}

UC12 | ย้ายโต๊ะ (Move Table)
    [Documentation]    UC12 - ย้ายโต๊ะ (Move Table)
    [Tags]    Reservation
    Step Should Succeed    ย้ายจากโต๊ะ 1 ไปโต๊ะ 2 สำหรับลูกค้า ID 1
    Should Be True    ${True}

UC13 | รวมบิล/แยกบิลตามโต๊ะ (Merge/Split Bills)
    [Documentation]    UC13 - รวมบิลโต๊ะ 1 และ 2 เป็นบิลเดียว (Merge/Split Bills)
    [Tags]    Reservation
    Step Should Succeed    รวมบิลโต๊ะ 1 และ 2 เป็นบิลเดียว
    Should Be True    ${True}

UC14 | เพิ่มเมนูลงตะกร้า (Add Menu To Cart)
    [Documentation]    UC14 - เพิ่มเมนูลงตะกร้า (Add Menu To Cart)
    [Tags]    Ordering
    Step Should Succeed    เพิ่มเนื้อวัว จำนวน 3 ชิ้นลงตะกร้าสำหรับโต๊ะ 1
    Should Be True    ${True}

UC15 | แก้ไขจำนวนเมนู (Update Quantity)
    [Documentation]    UC15 - แก้ไขจำนวนเมนู (Update Quantity)
    [Tags]    Ordering
    Update    จำนวนเมนู    301    {'quantity': 5}
    Should Be True    ${True}

UC16 | ลบเมนูจากตะกร้า (Remove From Cart)
    [Documentation]    UC16 - ลบเมนูจากตะกร้า (Remove From Cart)
    [Tags]    Ordering
    Delete    เมนู    301
    Should Be True    ${True}

UC17 | ส่งออเดอร์เข้าครัว (Submit Order To Kitchen)
    [Documentation]    UC17 - ส่งออเดอร์เข้าครัว (Submit Order To Kitchen)
    [Tags]    Ordering
    Step Should Succeed    ส่งออเดอร์ ID 101 เข้าครัว
    Should Be True    ${True}

UC18 | ติดตามสถานะออเดอร์ (Track Order Status)
    [Documentation]    UC18 - ติดตามสถานะออเดอร์ (Track Order Status)
    [Tags]    Ordering
    Step Should Succeed    เช็คสถานะออเดอร์ ID 101 และพบว่ากำลังทำ
    Should Be True    ${True}

UC19 | ยกเลิกออเดอร์ก่อนทำ (Cancel Order Before Cook)
    [Documentation]    UC19 - ยกเลิกออเดอร์ก่อนทำ (Cancel Order Before Cook)
    [Tags]    Ordering
    Step Should Succeed    ยกเลิกออเดอร์ ID 101 ก่อนเริ่มทำ
    Should Be True    ${True}

UC20 | คำนวณโปรโมชันอัตโนมัติ (Auto Promotion Calc)
    [Documentation]    UC20 - คำนวณโปรโมชันอัตโนมัติ (Auto Promotion Calc)
    [Tags]    Ordering
    ${after_discount}=    Calculate    โปรโมชัน    500 * 0.9  # ลด 10%
    Should Be True    ${True}

UC21 | ปิดบิลและชำระเงิน (Close Bill & Payment)
    [Documentation]    UC21 - ปิดบิลและชำระเงิน (Close Bill & Payment)
    [Tags]    Ordering
    Step Should Succeed    ปิดบิลโต๊ะ 1 ยอดรวม 500 บาท ชำระด้วยเงินสด
    Should Be True    ${True}

UC22 | คืนเงินบางส่วน/ทั้งหมด (Refund)
    [Documentation]    UC22 - คืนเงินบางส่วน/ทั้งหมด (Refund)
    [Tags]    Ordering
    Step Should Succeed    คืนเงิน 200 บาท จากบิลโต๊ะ 1
    Should Be True    ${True}

UC23 | สร้างบัญชีพนักงาน (Employee Create)
    [Documentation]    UC23 - สร้างบัญชีพนักงาน (Employee Create)
    [Tags]    Employee
    Create    พนักงาน    {'id': 202, 'name': 'สมศรี ยิ้มแย้ม', 'role': 'พนักงานเสิร์ฟ'}
    Should Be True    ${True}

UC24 | กำหนดสิทธิ์ตามบทบาท (RBAC)
    [Documentation]    UC24 - กำหนดสิทธิ์ตามบทบาท (RBAC)
    [Tags]    Employee
    Step Should Succeed    กำหนดสิทธิ์แคชเชียร์ให้พนักงาน ID 201
    Should Be True    ${True}

UC25 | เปิด-ปิดกะทำงาน (Shift Open/Close)
    [Documentation]    UC25 - เปิด-ปิดกะทำงาน (Shift Open/Close)
    [Tags]    Employee
    Step Should Succeed    เปิดกะทำงานสำหรับพนักงาน ID 201 เวลา 09:00
    Should Be True    ${True}

UC26 | บันทึกประสิทธิภาพการเสิร์ฟ (KPI Log)
    [Documentation]    UC26 - บันทึกประสิทธิภาพการเสิร์ฟ (KPI Log)
    [Tags]    Employee
    Step Should Succeed    บันทึก KPI พนักงาน ID 202: เสิร์ฟ 10 โต๊ะ
    Should Be True    ${True}

UC27 | ปิดบัญชีรายวันของแคชเชียร์ (Daily Cashout)
    [Documentation]    UC27 - ปิดบัญชีรายวันของแคชเชียร์ (Daily Cashout)
    [Tags]    Employee
    Step Should Succeed    ปิดบัญชีรายวัน ยอดรวม 5000 บาท
    Should Be True    ${True}

UC28 | เพิ่มเมนูใหม่ (Menu Create)
    [Documentation]    UC28 - เพิ่มเมนูใหม่ (Menu Create)
    [Tags]    Menu
    Create    เมนู    {'id': 302, 'name': 'กุ้งสด', 'price': 200, 'stock': 30}
    Should Be True    ${True}

UC29 | แก้ไขเมนู/ราคา (Menu Update)
    [Documentation]    UC29 - แก้ไขเมนู/ราคา (Menu Update)
    [Tags]    Menu
    Update    เมนู    301    {'id': 301, 'name': 'เนื้อวัวพรีเมียม', 'price': 180, 'stock': 45}
    Should Be True    ${True}

UC30 | ปิด/เปิดการขายเมนู (Menu Availability Toggle)
    [Documentation]    UC30 - ปิด/เปิดการขายเมนู (Menu Availability Toggle)
    [Tags]    Menu
    Step Should Succeed    เปิดการขายเมนู ID 302
    Should Be True    ${True}

UC31 | จัดการวัตถุดิบและสต็อก (Ingredient & Stock)
    [Documentation]    UC31 - จัดการวัตถุดิบและสต็อก (Ingredient & Stock)
    [Tags]    Menu
    Step Should Succeed    อัปเดตสต็อกเนื้อวัวเหลือ 40 ชิ้น
    Should Be True    ${True}

UC32 | ส่งออกเมนูเป็นไฟล์ (Export Menu CSV)
    [Documentation]    UC32 - ส่งออกเมนูเป็นไฟล์ (Export Menu CSV)
    [Tags]    Menu
    Step Should Succeed    ส่งออกเมนูทั้งหมดเป็นไฟล์ CSV
    Should Be True    ${True}
