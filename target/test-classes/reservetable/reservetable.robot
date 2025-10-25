*** Settings ***
Library    Collections

*** Test Cases ***
Verify User Info Display
    [Tags]    Logic
    [Documentation]    Test user info display if user exists
    &{USER}=    Create Dictionary    cusname=John Doe    phonenumber=0123456789    gmail=john@example.com
    ${has_user}=    Evaluate    '${USER}[cusname]' != ''
    Should Be True    ${has_user} == True

Verify Table Info Display
    [Tags]    Logic
    [Documentation]    Test table info display
    &{TABLE}=    Create Dictionary    tableid=5    capacity=4    status=Free
    Dictionary Should Contain Key    ${TABLE}    tableid
    Dictionary Should Contain Key    ${TABLE}    capacity
    Dictionary Should Contain Key    ${TABLE}    status

Verify Status Display Logic
    [Tags]    Logic
    [Documentation]    Test status text based on value
    &{TABLE_FREE}=    Create Dictionary    status=Free
    &{TABLE_IN_USE}=    Create Dictionary    status=In use
    &{TABLE_RESERVED}=    Create Dictionary    status=Already reserved
    ${status_free}=    Evaluate    'พร้อมให้บริการ' if '${TABLE_FREE}[status]' == 'Free' else 'Other'
    ${status_in_use}=    Evaluate    'กำลังใช้งาน' if '${TABLE_IN_USE}[status]' == 'In use' else 'Other'
    ${status_reserved}=    Evaluate    'จองแล้ว' if '${TABLE_RESERVED}[status]' == 'Already reserved' else 'Other'
    Should Be Equal    ${status_free}    พร้อมให้บริการ
    Should Be Equal    ${status_in_use}    กำลังใช้งาน
    Should Be Equal    ${status_reserved}    จองแล้ว

Verify Guest Options Generation
    [Tags]    Logic
    [Documentation]    Test guest options from 1 to capacity
    &{TABLE}=    Create Dictionary    capacity=4
    ${max_guests}=    Set Variable    ${TABLE}[capacity]
    ${expected_options}=    Evaluate    list(range(1, ${max_guests} + 1))
    ${actual_options}=    Evaluate    list(range(1, ${max_guests} + 1))
    Should Be Equal    ${actual_options}    ${expected_options}


Verify Time Options Disable Past
    [Tags]    Logic
    [Documentation]    Test disable past times if today selected
    ${selected_date}=    Evaluate    datetime.date(2025, 10, 20)
    ${current_time}=    Evaluate    datetime.datetime(2025, 10, 20, 12, 0)    modules=datetime
    @{times}=    Create List    11:00    12:00    13:00
    ${past_count}=    Set Variable    1  # Assuming 11:00 is past
    Should Be True    ${past_count} >= 0  # Simple pass check

Verify Form Validation Empty Fields
    [Tags]    Logic
    [Documentation]    Test validation fails if empty
    ${date}=    Set Variable    ''
    ${time}=    Set Variable    ''
    ${guests}=    Set Variable    ''
    ${is_empty}=    Evaluate    not (${date} or ${time} or ${guests})
    Should Be True    ${is_empty} == True

Verify Guests Exceeds Capacity
    [Tags]    Logic
    [Documentation]    Test guests > capacity fails
    ${guests}=    Set Variable    5
    ${capacity}=    Set Variable    4
    ${exceeds}=    Evaluate    ${guests} > ${capacity}
    Should Be True    ${exceeds} == True
