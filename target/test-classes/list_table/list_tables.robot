*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    http://localhost:8082/Zproject_shabu2/listTable  # Replace with your actual JSP URL
${BROWSER}    Chrome  # Or Firefox, Edge, etc.

*** Test Cases ***
Verify Table Management Page Loads Correctly
    [Tags]    Verify
    [Documentation]    Basic smoke test for page load and title
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    Title Should Be    Restaurant Table Management
    Page Should Contain    Table Overview
    Page Should Contain Element    id=totalTables
    Page Should Contain Element    id=searchInput
    [Teardown]    Close Browser

Search And Filter Tables
    [Tags]    Verify
    [Documentation]    Test search and filter functionality
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    0.5s
    # Test search
    Input Text    id=searchInput    TT001  # Assuming a table like T1 exists
    Wait Until Page Contains Element    css=.table-card  # Wait for tables to appear
    Page Should Contain Element    css=.table-card[data-status="Free"]  # Check for available table
    [Teardown]    Close Browser