*** Settings ***
Library    SeleniumLibrary
Library    Process
# Suite Setup    Start Selenium Grid

*** Test Cases ***
Open Three Browsers On Grid
    [Documentation]    Mở Google, Bing và DuckDuckGo trên 3 Node Grid khác nhau
    ${caps1}=    Evaluate    {"se:nodeTags": ["nodeA"], "browserName": "chrome"}    json
    ${caps2}=    Evaluate    {"se:nodeTags": ["nodeB"], "browserName": "firefox"}   json
    ${caps3}=    Evaluate    {"se:nodeTags": ["nodeC"], "browserName": "safari"}    json


    Open Browser    https://www.google.com       chrome    remote_url=http://10.117.64.118:4444    desired_capabilities=${caps1}    alias=Google
    Open Browser    https://www.bing.com         firefox    remote_url=http://10.117.64.118:4444    desired_capabilities=${caps2}    alias=Bing
    Open Browser    https://www.duckduckgo.com   safari    remote_url=http://10.117.64.118:4444    desired_capabilities=${caps3}    alias=DuckDuckGo

    Switch Browser    Google
    Title Should Be    Google

    Switch Browser    Bing
    Title Should Be    Search - Microsoft Bing

    Switch Browser    DuckDuckGo
    Title Should Be    DuckDuckGo - Protection. Privacy. Peace of mind.

    Close All Browsers

*** Keywords ***
Start Selenium Grid
    [Documentation]    Khởi động Selenium Grid 3 node bằng Docker
    Run Process    ./selenium_grid_start.sh
    Sleep    5s
