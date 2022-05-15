*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Search for Topic
    go to    https://en.wikipedia.org/wiki/Main_Page
    wait until page contains    Main Page
    input text    id=searchInput    robot framework
    click button    id=searchButton
    wait until page contains    Robot Framework is a generic test automation

Try To Edit Topic
    click link    xpath=//*[@id="ca-edit"]/a
    wait until page contains    You are not logged in.