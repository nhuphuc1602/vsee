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
    Sleep    4
    Wait Until Element Is Visible    ${CALL_SCREEN}
    Select Frame    ${JITSI_FRAME}
    Wait Until Element Is Visible    ${JOIN_NOW}    10
    Click Element    ${JOIN_NOW}
    Unselect Frame
    Wait Until Element Is Visible    ${WAITING_ROOM}





