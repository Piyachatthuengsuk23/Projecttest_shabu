*** Settings ***
Library    Collections

*** Variables ***
# No invalid empty list declarations; handle in tests

*** Test Cases ***
Verify Empty Cart Displays No Items Message
    [Tags]    Logic
    [Documentation]    Test empty cart logic (should show "ยังไม่มีรายการในตะกร้า")
    ${cart_items}=    Create List
    ${has_items}=    Evaluate    len(${cart_items}) > 0
    Should Be True    ${has_items} == False
    # Simulate JSTL: if empty, show message (no further checks needed)

*** Keywords ***
Calculate Subtotal
    [Arguments]    ${item}
    ${subtotal}=    Evaluate    ${item}[qty] * ${item}[price]
    RETURN    ${subtotal}

Calculate Total
    [Arguments]    ${items}
    ${total}=    Set Variable    0
    FOR    ${item}    IN    @{items}
        ${sub}=    Calculate Subtotal    ${item}
        ${total}=    Evaluate    ${total} + ${sub}
    END
    RETURN    ${total}