*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/browser.robot
Resource    ../variables/env_variables.robot

# Suite Setup    Open Browser To Room    ${ROOM_URL}
Suite Teardown    Close All Browsers

*** Test Cases ***
User Chat Call Flow
    [Documentation]    Provider logs in, calls patient, sends message, ends call.
    # Open Browser To Room    ${ROOM_URL}
    Login As Provider    ${ROOM_URL}    ${PROVIDER_USERNAME}    ${PROVIDER_PASSWORD}
    # Add chat steps here
    # Open Browser To Room    ${ROOM_URL}
    Login As Patient    ${ROOM_URL}
