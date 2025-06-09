*** Settings ***
Library     ../github_utils/github_api.py
Resource    ../variables/env_variables.robot

*** Test Cases ***
Get GitHub Stats
    ${user_or_org}=    Set Variable    SeleniumHQ

    ${token}=    Set Variable If    '${GITHUB_TOKEN}' != ''    ${GITHUB_TOKEN}    ${None}
    
    ${issues}=    Get All Open Issues    ${user_or_org}    ${token}
    Log    Total issues: ${issues}

    ${repos}=    Get Sorted Repos By Update    ${user_or_org}    ${token}
    Log    Most recently updated: ${repos[0]['name']}

    ${top}=    Get Repo With Most Watchers    ${user_or_org}    ${token}
    Log    Most watched repo: ${top['name']} (${top['watchers_count']})