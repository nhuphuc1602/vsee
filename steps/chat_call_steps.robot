*** Settings ***
Resource    ../pages/browser.robot
Resource    ../pages/patient_page.robot
Resource    ../pages/provider_page.robot
Resource    ../pages/video_call_page.robot
Resource    ../variables/env_variables.robot

*** Keywords ***
Patient Logs In To Waiting Room
    [Documentation]    Patient logs in to the waiting room using the provided room URL.
    Login As Patient    ${ROOM_URL}

Patient Logs In To Waiting Room (Use Grid)
    [Documentation]    Patient logs in to the waiting room using Selenium Grid.
    Login As Patient    ${ROOM_URL}    ${True}

Provider Logs In To Dashboard
    [Documentation]    Provider logs in to the dashboard using the provided credentials.
    Login As Provider    ${ROOM_URL}    ${PROVIDER_USERNAME}    ${PROVIDER_PASSWORD}

Provider Logs In To Dashboard (Use Grid)
    [Documentation]    Provider logs in to the dashboard using Selenium Grid and provided credentials.
    Login As Provider (Use Grid)    ${ROOM_URL}    ${PROVIDER_USERNAME}    ${PROVIDER_PASSWORD}
    
Provider Starts Call
    [Documentation]    Provider initiates a video call to the patient.
    Start Provider Call

Provider Joins Meeting
    [Documentation]    Provider joins the ongoing video meeting.
    Join Provider Meeting

Provider Opens Chat
    [Documentation]    Provider opens the chat panel during the meeting.
    Open Provider Chat

Provider Sends Chat Message
    [Documentation]    Provider sends a chat message ("hello") to the patient.
    Send Provider Chat Message    hello

Patient Verifies Chat Message
    [Documentation]    Patient switches to their browser and verifies the received chat message.
    Switch To Patient Browser
    Patient Verify Chat Message    hello

Provider Leaves Meeting
    [Documentation]    Provider switches to their browser and leaves the video meeting.
    Switch To Provider Browser
    Provider Leave Meeting

Patient Ends Visit
    [Documentation]    Patient switches to their browser, leaves the call, and ends the visit.
    Switch To Patient Browser
    Patient Leave Call
    Patient End Visit
