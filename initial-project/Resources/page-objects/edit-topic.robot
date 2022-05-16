*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Start Editing Topic
    click link    xpath=//*[@id="ca-edit"]/a

Notify Login Status
    wait until page contains    You are not logged in.