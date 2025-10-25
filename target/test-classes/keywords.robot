*** Keywords ***
Open Browser To Register Page
    [Documentation]    Opens the browser and navigates to the registration page
    Open Browser    ${REGISTER_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    id=registerForm

Fill Registration Form
    [Documentation]    Fills the registration form with provided inputs
    [Arguments]    ${username}    ${password}    ${name}    ${phonenumber}    ${age}    ${email}
    Input Text    id=username    ${username}
    Input Text    id=password    ${password}
    Input Text    id=name    ${name}
    Input Text    id=phonenumber    ${phonenumber}
    Input Text    id=age    ${age}
    Input Text    id=email    ${email}

Submit Registration Form
    [Documentation]    Submits the registration form
    Click Button    xpath=//button[@type='submit']

Verify Registration Success
    [Documentation]    Verifies successful registration
    Wait Until Page Contains    ${SUCCESS_MESSAGE}    timeout=5s
    [Teardown]    Capture Page Screenshot

Verify Required Field Error
    [Documentation]    Verifies error for missing required field
    Wait Until Page Contains    Please fill out this field    timeout=5s
    [Teardown]    Capture Page Screenshot

Verify Invalid Email Error
    [Documentation]    Verifies error for invalid email format
    Wait Until Page Contains    Please include an '@' in the email address    timeout=5s
    [Teardown]    Capture Page Screenshot