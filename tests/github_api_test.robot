*** Settings ***
Library     ../github_utils/github_api.py
Resource    ../variables/env_variables.robot

*** Test Cases ***
Get GitHub Stats
    ${issues}=    Get All Open Issues    ${GITHUB_ORG}
    Log    Total issues: ${issues}

    ${repos}=    Get Sorted Repos By Update    ${GITHUB_ORG}
    Log    Most recently updated: ${repos[0]['name']}

    ${top}=    Get Repo With Most Watchers    ${GITHUB_ORG}
    Log    Most watched repo: ${top['name']} (${top['watchers_count']})
