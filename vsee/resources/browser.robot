*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Open Browser To Room
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window

Login As Provider
    [Arguments]    ${url}    ${username}    ${password}
    Open Browser    ${url}    chrome
    Click Link    /providers/login
    Input Text    id=AppUserUsername    ${username}
    Input Text    id=AppUserPassword    ${password}
    Click Button    id=btnSignIn

Login As Patient
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    Input Text    id=jsonform-1-elt-first_name    phuc test
    Input Text    id=jsonform-1-elt-reason_for_visit    sick
    Click Button    id=jsonform-1-elt-consent
    Click Button    xpath=//input[@type="submit"]
    Wait Until Element Is Visible    xpath=//h3[text()='Continue on this browser']
    Click Element    xpath=//h3[text()='Continue on this browser']
    Wait Until Element Is Visible    xpath=//div[@id="ReminderModal"]//h4[@class="modal-title"]    15
    Element Should Contain    xpath=//div[@id="ReminderModal"]//h4[@class="modal-title"]    Welcome