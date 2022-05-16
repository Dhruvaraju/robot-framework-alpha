*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Load Wikipedia
    go to    https://en.wikipedia.org/wiki/Main_Page

Verify Page Load
    wait until page contains    Main Page

Search For Topic
    input text    id=searchInput    robot framework
    click button    id=searchButton

Verify Topic Page Load
    wait until page contains    Robot Framework is a generic test automation