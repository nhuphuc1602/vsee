*** Settings ***
Resource    ../steps/chat_call_steps.robot

*** Test Cases ***
Patient-Provider Chat and Call Flow (Local)
    [Documentation]    End-to-end test on a single machine:
    ...                Patient joins waiting room,
    ...                Provider logs in, starts a call, sends a chat message,
    ...                Patient verifies the message,
    ...                Then both end the call.    
    Patient Logs In To Waiting Room
    Provider Logs In To Dashboard
    Provider Starts Call
    Provider Joins Meeting
    Provider Opens Chat
    Provider Sends Chat Message
    Patient Verifies Chat Message
    Provider Leaves Meeting
    Patient Ends Visit
    [Teardown]    Close All Browsers

Patient-Provider Chat and Call Flow With Local Grid (Different Machine)
    [Documentation]    Test using manually started local Selenium Grid:
    ...                Simulates two machines with distributed browser sessions.
    ...                Includes grid startup, call flow, chat verification, and teardown.    
    [Setup]    Run Keywords
    ...        Kill Ports For Selenium Grid    AND
    ...        Start Selenium Grid
    Patient Logs In To Waiting Room (Use Grid)
    Provider Logs In To Dashboard (Use Grid)
    Provider Starts Call
    Provider Joins Meeting
    Provider Opens Chat
    Provider Sends Chat Message
    Patient Verifies Chat Message
    Provider Leaves Meeting
    Patient Ends Visit
    [Teardown]    Run Keywords
    ...           Close All Browsers    AND
    ...           Teardown Selenium Grid

Patient-Provider Chat and Call Flow With Docker Grid (Different Machine)
    [Documentation]    Test using Docker-based Selenium Grid:
    ...                Grid is started via Docker Compose.
    ...                Simulates distributed call/chat flow and performs clean grid shutdown.
    [Timeout]  10 minutes
    [Setup]    Start Docker Compose And Wait
    Patient Logs In To Waiting Room (Use Grid)    4454
    Provider Logs In To Dashboard (Use Grid)    4454
    Provider Starts Call
    Provider Joins Meeting
    Provider Opens Chat
    Provider Sends Chat Message
    Patient Verifies Chat Message
    Provider Leaves Meeting
    Patient Ends Visit
    [Teardown]     Run Keywords
    ...            Close All Browsers    AND    
    ...            Stop Docker Compose
