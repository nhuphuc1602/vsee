*** Settings ***
Library    SeleniumLibrary
Library    ../custom_libs/JsClickKeyword.py
Resource   ../locator/provider_page.robot
Resource   ../locator/patient_page.robot
Resource   ../locator/video_call_page.robot
Resource   ../pages/video_call_page.robot
Resource   ../pages/browser.robot

*** Keywords ***
Login As Provider
    [Arguments]    ${url}    ${username}    ${password}
    Open Provider Login Page    ${url}
    Input Provider Credentials    ${username}    ${password}
    Submit Provider Login
    Wait For Provider Home

Login As Provider (Use Grid)
    [Arguments]    ${url}    ${username}    ${password}
    Open Provider Login Page    ${url}    ${True}
    Input Provider Credentials    ${username}    ${password}
    Submit Provider Login
    Wait For Provider Home    

Open Provider Login Page
    [Arguments]    ${url}    ${use_grid}=False
    Open Browser With Media Options    ${url}    ${use_grid}    provider
    Click Link    ${LOGIN_LINK}

Input Provider Credentials
    [Arguments]    ${username}    ${password}
    Input Text    ${USERNAME_INPUT}    ${username}
    Input Text    ${PASSWORD_INPUT}    ${password}

Submit Provider Login
    Click Button    ${SIGNIN_BUTTON}

Wait For Provider Home
    Wait Until Element Is Visible    ${USERNAME_SPAN}
    Wait Until Element Is Visible    ${READY_FOR_VISITS}

Start Provider Call
    Check Timezone Sync
    Wait Until Element Is Visible    ${CALL_LINK}
    Click Element    ${CALL_LINK}
    Wait Until Element Is Visible    ${CONTINUE_BROWSER}
    Click Element    ${CONTINUE_BROWSER}
    Sleep    5

Join Provider Meeting
    Select Frame    ${JITSI_FRAME}
    Wait Until Element Is Visible    ${JOIN_NOW}    10
    Click Element    ${JOIN_NOW}

Open Provider Chat
    Wait Until Element Is Visible    ${OPEN_CHAT}    10
    Click Element    ${OPEN_CHAT}
    Unselect Frame
    Wait Until Element Is Visible    ${CHAT_MESSAGE_NOTICE}

Send Provider Chat Message
    [Arguments]    ${message}
    Input Text    ${CHAT_INPUT}    ${message}
    Press Keys    ${CHAT_INPUT}    RETURN

Provider Leave Meeting
    Select Frame    ${JITSI_FRAME}
    Click Element    ${LEAVE_MEETING}
    Unselect Frame
    Wait Until Element Is Visible    xpath=//label[text()='Would you like to']
    Click Element    ${LEAVE_CALL_BTN}
    Wait Until Element Is Visible    ${USERNAME_SPAN}

Check Timezone Sync
    ${passed} =    Run Keyword And Return Status    Wait Until Element Is Visible    ${TIMEZONE_POPUP}
    Run Keyword If    ${passed}    Click Element    ${TIMEZONE_CANCEL_BTN}