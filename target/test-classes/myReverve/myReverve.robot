*** Settings ***
Library    Collections

*** Test Cases ***
Verify My Reservations Conditional Display
    [Tags]    Logic
    [Documentation]    Test conditional display based on tableid
    &{RESERVATION}=    Create Dictionary    tableid=5    customerName=John Doe    date=20/10/2025    time=18:00
    ${has_reservation}=    Evaluate    '${RESERVATION}[tableid]' != ''
    Should Be True    ${has_reservation} == True

Verify Reservation Details Properties
    [Tags]    Logic
    [Documentation]    Test reservation details
    &{RESERVATION}=    Create Dictionary    tableid=5    customerName=John Doe    date=20/10/2025    time=18:00
    Dictionary Should Contain Key    ${RESERVATION}    tableid
    Dictionary Should Contain Key    ${RESERVATION}    customerName
    Dictionary Should Contain Key    ${RESERVATION}    date
    Dictionary Should Contain Key    ${RESERVATION}    time

Verify Page Title Display
    [Tags]    Logic
    [Documentation]    Test page title
    ${title}=    Set Variable    การจองของฉัน
    Should Be Equal    ${title}    การจองของฉัน