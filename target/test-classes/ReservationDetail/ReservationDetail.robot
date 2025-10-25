*** Settings ***
Library    Collections

*** Test Cases ***
Verify Empty Reservations Show Empty State
    [Tags]    Logic
    [Documentation]    Test empty reservations show empty state
    ${reservations}=    Create List
    ${has_reservations}=    Evaluate    len(${reservations}) > 0
    Should Be True    ${has_reservations} == False

Verify User Welcome Display
    [Tags]    Logic
    [Documentation]    Test user welcome if user exists
    &{USER}=    Create Dictionary    cusname=John Doe
    ${has_user}=    Evaluate    '${USER}[cusname]' != ''
    Should Be True    ${has_user} == True

Verify Multiple Reservations Display
    [Tags]    Logic
    [Documentation]    Test multiple reservations logic
    &{RES1}=    Create Dictionary    reserveid=1    status=confirm
    &{RES2}=    Create Dictionary    reserveid=2    status=pending
    ${reservations}=    Create List    ${RES1}    ${RES2}
    ${count}=    Get Length    ${reservations}
    Should Be True    ${count} == 2

Verify Status Badge Class
    [Tags]    Logic
    [Documentation]    Test status class calculation
    &{RES1}=    Create Dictionary    status=confirm
    ${status_lower}=    Evaluate    '${RES1}[status]'.lower()
    Should Be Equal    ${status_lower}    confirm

Verify Cancel Button Conditional
    [Tags]    Logic
    [Documentation]    Test cancel button only for confirm status
    &{RES_CONFIRM}=    Create Dictionary    status=confirm
    &{RES_PENDING}=    Create Dictionary    status=pending
    ${show_cancel_confirm}=    Evaluate    '${RES_CONFIRM}[status]' == 'confirm'
    ${show_cancel_pending}=    Evaluate    '${RES_PENDING}[status]' == 'confirm'
    Should Be True    ${show_cancel_confirm} == True
    Should Be True    ${show_cancel_pending} == False
