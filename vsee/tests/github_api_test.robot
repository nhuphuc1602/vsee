*** Settings ***
Library    ../github_utils/github_api.py

*** Test Cases ***
Get GitHub Stats
    ${issues}=    Get All Open Issues    SeleniumHQ
    Log    Total issues: ${issues}

    ${repos}=    Get Sorted Repos By Update    SeleniumHQ
    Log    Most recently updated: ${repos[0]['name']}

    ${top}=    Get Repo With Most Watchers    SeleniumHQ
    Log    Most watched repo: ${top['name']} (${top['watchers_count']})
