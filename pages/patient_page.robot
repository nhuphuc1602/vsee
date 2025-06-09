*** Settings ***
Library    SeleniumLibrary
Library    ../custom_libs/JsClickKeyword.py
Resource   ../locator/provider_page.robot
Resource   ../locator/patient_page.robot
Resource   ../locator/video_call_page.robot
Resource   ../pages/video_call_page.robot
Resource   ../pages/browser.robot

*** Keywords ***
Login As Patient
    [Arguments]    ${url}    ${use_grid}=False    ${port}=4444    ${browser}=chrome
    Open Browser With Media Options    ${url}    ${use_grid}    patient    ${port}    ${browser}
    Fill Patient Info And Join

Fill Patient Info And Join
    Log To Console    1.1
    Wait Until Element Is Visible    ${CLINIC_GUEST}
    Input Text    ${FIRST_NAME_INPUT}    phuc test
    Input Text    ${REASON_INPUT}    sick
    Click Button    ${CONSENT_BUTTON}
    Click Button    ${SUBMIT_BUTTON}
    Join To The Room

Verify Patient Chat Message
    [Arguments]    ${message}
    Wait Until Element Is Visible    ${MESSAGE_BUBBLE}
    Element Text Should Be    ${MESSAGE_BUBBLE}    ${message}

Patient Verify Chat Message
    [Arguments]    ${message}
    Wait Until Element Is Visible    ${CHAT_MESSAGE_NOTICE}    10
    Wait Until Element Is Visible    ${MESSAGE_BUBBLE}
    Element Text Should Be    ${MESSAGE_BUBBLE}    ${message}

Patient Leave Call
    Select Frame    ${JITSI_FRAME}
    JS Click    ${LEAVE_MEETING}
    Unselect Frame

Patient End Visit
    Wait Until Element Is Visible    ${VISIT_SURVEY}
    Click Element    ${END_VISIT_BTN}
    Wait Until Element Is Visible    ${CLINIC_GUEST}
