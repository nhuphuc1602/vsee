*** Settings ***
Library    SeleniumLibrary
Library    ../custom_libs/JsClickKeyword.py
Resource   ../locator/provider_page.robot
Resource   ../locator/patient_page.robot
Resource   ../locator/video_call_page.robot

*** Keywords ***
Join To The Room
    Wait Until Element Is Visible    ${CONTINUE_BROWSER}
    Click Element    ${CONTINUE_BROWSER}
    Sleep    5
    Wait Until Element Is Visible    ${CALL_SCREEN}
    Select Frame    ${JITSI_FRAME}
    Wait Until Element Is Visible    ${JOIN_NOW}    10
    Click Element    ${JOIN_NOW}
    Wait Until Element Is Not Visible    ${JOIN_NOW}    10
    Unselect Frame





