*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Library           Process
Resource          ../variables/env_variables.robot

Suite Setup       Start Selenium Grid

*** Test Cases ***
UserA And UserB On Docker Grid
    [Documentation]    Mô phỏng 2 user gọi điện và gửi chat qua Selenium Grid Docker

    Open Browser    ${ROOM_URL}    chrome    remote_url=http://localhost:4444/wd/hub    alias=UserA
    Maximize Browser Window

    Open Browser    ${ROOM_URL}    chrome    remote_url=http://localhost:4444/wd/hub    alias=UserB
    Maximize Browser Window

    Switch Browser    UserB
    Click Link    For Providers
    Input Text    id=username    ${PROVIDER_USERNAME}
    Input Text    id=password    ${PROVIDER_PASSWORD}
    Click Button    id=login
    Click Button    xpath=//button[contains(., 'Continue on this browser')]

    Sleep    3s
    Input Text    xpath=//input[@placeholder='Type your message']    Hello UserA
    Press Keys     xpath=//input[@placeholder='Type your message']    RETURN

    Switch Browser    UserA
    Wait Until Page Contains    Hello UserA    timeout=10s

    Switch Browser    UserB
    Click Button    xpath=//button[contains(., 'End Call')]

    Switch Browser    UserA
    Click Button    xpath=//button[contains(., 'End Call')]

    Close All Browsers

*** Keywords ***
Start Selenium Grid
    [Documentation]    Khởi động Docker Grid từ file shell
    Run Process    ./selenium_grid_start.sh
    Sleep    5s
