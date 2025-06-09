*** Settings ***
Library    SeleniumLibrary
Library    ../custom_libs/JsClickKeyword.py
Resource   ../locator/provider_page.robot
Resource   ../locator/patient_page.robot
Resource   ../locator/video_call_page.robot

*** Keywords ***
Join To The Room
    Log To Console    1.2
    Wait Until Element Is Visible    ${CONTINUE_BROWSER}
    Click Element    ${CONTINUE_BROWSER}
    Sleep    4
    Wait Until Element Is Visible    ${CALL_SCREEN}
    Select Frame    ${JITSI_FRAME}
    Wait Until Element Is Visible    ${JOIN_NOW}    10
    Click Element    ${JOIN_NOW}
    Log To Console    1.3
    Sleep    10
    Log To Console    1.4
    Capture Page Screenshot
    # Wait Until Element Is Not Visible    ${JOIN_NOW}    10
    Log To Console    1.5
    Capture Page Screenshot
    Unselect Frame
    Run Keyword And Ignore Error    Wait Until Element Is Visible    ${TEXT_ME_POPUP}
    Capture Page Screenshot





