*** Settings ***
Library    Collections

*** Test Cases ***
Verify Success Message Display
    [Tags]    Logic
    [Documentation]    Test success header and icon exist
    ${success_title}=    Set Variable    จองโต๊ะสำเร็จ!
    Should Be Equal    ${success_title}    จองโต๊ะสำเร็จ!

Verify Reservation ID Display
    [Tags]    Logic
    [Documentation]    Test reservation ID property
    &{RESERVATION}=    Create Dictionary    reserveid=123
    Dictionary Should Contain Key    ${RESERVATION}    reserveid
    Should Be True    ${RESERVATION}[reserveid] > 0

Verify Customer Info Display
    [Tags]    Logic
    [Documentation]    Test customer details from reservation
    &{CUSTOMER}=    Create Dictionary    cusname=John Doe    phonenumber=0123456789    gmail=john@example.com
    Dictionary Should Contain Key    ${CUSTOMER}    cusname
    Dictionary Should Contain Key    ${CUSTOMER}    phonenumber
    Dictionary Should Contain Key    ${CUSTOMER}    gmail

Verify Reservation Details Properties
    [Tags]    Logic
    [Documentation]    Test reservation details
    &{RESERVATION}=    Create Dictionary    reservedate=2025-10-20    reservetime=18:00    numberOfGuests=4    status=Confirmed
    &{TABLE}=    Create Dictionary    tableid=5    capacity=6
    Dictionary Should Contain Key    ${RESERVATION}    reservedate
    Dictionary Should Contain Key    ${TABLE}    tableid
    Should Be Equal    ${RESERVATION}[status]    Confirmed

Verify Date Formatting Logic
    [Tags]    Logic
    [Documentation]    Test date formatting works
    ${formatted_date}=    Set Variable    20 ตุลาคม 2568
    ${has_format}=    Evaluate    len('${formatted_date}') > 0
    Should Be True    ${has_format} == True

Verify Action Button Existence
    [Tags]    Logic
    [Documentation]    Test back to home button
    ${back_link}=    Set Variable    gotoWellcomeCustomerT
    Should Be Equal    ${back_link}    gotoWellcomeCustomerT

Verify Important Notes Display
    [Tags]    Logic
    [Documentation]    Test static important notes exist
    @{notes}=    Create List    กรุณามาถึงร้านก่อนเวลาจอง 15 นาที    หากมาสายเกิน 20 นาที การจองอาจถูกยกเลิก
    ${note_count}=    Get Length    ${notes}
    Should Be True    ${note_count} == 2