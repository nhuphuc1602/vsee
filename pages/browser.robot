*** Settings ***
Library    SeleniumLibrary
Library    Process
Library    OperatingSystem
Library    String
Library    BuiltIn
Library    Collections
Library    RequestsLibrary
Library    ../custom_libs/JsClickKeyword.py
Resource   ../locator/provider_page.robot
Resource   ../locator/patient_page.robot
Resource   ../locator/video_call_page.robot

*** Variables ***
${SELENIUM_JAR}         selenium-server-4.33.0.jar
${GRID_CONFIG_DIR}      grid_config

*** Keywords ***
Open Browser With Media Options
    [Documentation]    Open a Chrome browser with media stream options, optionally using Selenium Grid.
    [Arguments]    ${url}    ${use_grid}=False    ${alias}=1
    ${caps}=    Evaluate    {"se:nodeTags": ["${alias}"], "browserName": "chrome"}    json
    Run Keyword If    '${use_grid}' == 'True'
    ...    Open Browser    ${url}    chrome    options=add_argument("--use-device-ui-for-media-stream"); add_argument("----use-fake-ui-for-media-stream")    remote_url=http://localhost:4444    desired_capabilities=${caps}    alias=${alias}
    ...    ELSE
    ...    Open Browser    ${url}    chrome    options=add_argument("--use-device-ui-for-media-stream"); add_argument("----use-fake-ui-for-media-stream")    alias=${alias}
    Maximize Browser Window

Switch To Patient Browser
    Switch Browser    patient

Switch To Provider Browser
    Switch Browser    provider

# --- Selenium Grid Management ---

Start Selenium Grid
    [Documentation]    Start Selenium Grid hub and nodes as background processes.
    Start Process    java    -jar    ${SELENIUM_JAR}    hub    --host    localhost
    ...    stdout=hub.log    stderr=STDOUT    alias=hub
    Sleep    5s
    Start Process    java    -jar    ${SELENIUM_JAR}    node    --config    ${GRID_CONFIG_DIR}/master.json    --port    5555
    ...    stdout=master.log    stderr=STDOUT    alias=master
    Start Process    java    -jar    ${SELENIUM_JAR}    node    --config    ${GRID_CONFIG_DIR}/patient.json    --port    6666
    ...    stdout=patient.log    stderr=STDOUT    alias=patient
    Start Process    java    -jar    ${SELENIUM_JAR}    node    --config    ${GRID_CONFIG_DIR}/provider.json    --port    7777
    ...    stdout=provider.log    stderr=STDOUT    alias=provider
    Sleep    5s

Teardown Selenium Grid
    [Documentation]    Terminate all Selenium Grid processes.
    Terminate Process    hub
    Terminate Process    master
    Terminate Process    patient
    Terminate Process    provider

Kill Ports For Selenium Grid
    [Documentation]    Kill all ports used by Selenium Grid.
    Kill Port    4444
    Kill Port    5555
    Kill Port    6666
    Kill Port    7777

Start Selenium Grid Local
    Run Process    ./run-grid.sh    shell=True    alias=selenium_grid
    Check Selenium Grid Health With While

Stop Selenium Grid Local
    Terminate Process    selenium_grid

Check Selenium Grid Health With While
    ${max_attempts}=    Set Variable    5
    ${wait_seconds}=    Set Variable    2
    ${success}=         Set Variable    ${False}
    ${loop_limit}=      Evaluate        ${max_attempts} + 1

    FOR    ${attempt}    IN RANGE    1    ${loop_limit}
        Log    Attempting to connect, try number ${attempt}...
        ${status}    ${ignore}=    Run Keyword And Ignore Error    Selenium Grid Health Check
        Run Keyword If    '${status}' == 'PASS'    Set Test Variable    ${success}    ${True}
        Log    ${success}
        Run Keyword If    ${success}    Exit For Loop
        Sleep    ${wait_seconds}
    END

    IF    '${success}' == 'False'
        Fail    Selenium Grid UI did not return HTTP 200 after ${max_attempts} attempts
    END

Selenium Grid Health Check
    Create Session    selenium    http://localhost:4444
    ${response}=    GET On Session    selenium    /ui/
    Log    Status code: ${response.status_code}
    Log    Response snippet: ${response.text[:200]}
    Should Be Equal As Integers    ${response.status_code}    200

# --- Docker Compose Management ---

Start Docker Compose And Wait
    [Documentation]    Start Docker Compose and wait until all containers are running.
    [Arguments]    ${compose_file}=docker-compose.yml
    Run Process    docker-compose -f ${compose_file} up -d    shell=True    stdout=PIPE    stderr=PIPE
    Wait Until Docker Containers Are Running

Wait Until Docker Containers Are Running
    [Documentation]    Wait until all required Docker containers are running.
    FOR    ${i}    IN RANGE    10
        ${result}    Run Process    docker ps --format "{{.Names}}:{{.Status}}"    shell=True    stdout=PIPE    stderr=PIPE
        ${output}    Set Variable    ${result.stdout}
        Log    ${output}
        Should Contain    ${output}    selenium-hub
        Should Contain    ${output}    provider-node
        Should Contain    ${output}    patient-node
        ${is_up}=    Evaluate    'Up' in """${output}"""
        Exit For Loop If    ${is_up}
        Sleep    3s
        Fail    Containers did not start after 30 seconds
    END
    Check Selenium Grid Health With While

Stop Docker Compose
    [Arguments]    ${compose_file}=docker-compose.yml
    Run Process    docker-compose -f ${compose_file} down    shell=True

# --- Port Management Utilities ---

Kill Port
    [Arguments]    ${PORT}
    ${OS}=    Evaluate    sys.platform    sys
    Run Keyword If    '${OS}' == 'linux' or '${OS}' == 'darwin'
    ...    Run Process    bash    -c    lsof -ti:${PORT} | xargs kill -9
    ...    ELSE IF    '${OS}' == 'win32'
    ...    Kill Port On Windows    ${PORT}

Kill Port On Windows
    [Arguments]    ${port}
    ${output}=    Run Process    cmd    /c    netstat -ano | findstr :${port}    shell=True    stdout=PIPE
    ${lines}=     Split String    ${output.stdout}    \n
    FOR    ${line}    IN    @{lines}
        ${line}=    Strip String    ${line}
        Run Keyword If    '${line}' != ''    Handle Line    ${line}
    END

Handle Line
    [Arguments]    ${line}
    ${parts}=    Split String    ${line}
    ${pid}=      Get From List    ${parts}    -1
    Run Process    taskkill    /PID    ${pid}    /F    stdout=NONE    stderr=NONE
