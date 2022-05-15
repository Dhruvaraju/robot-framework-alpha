*** Settings ***
Documentation    Load Dexter wikipedia page
Library    SeleniumLibrary
*** Variables ***

*** Test Cases ***
Navigate to wikipedia page
    [Documentation]    Identify Dexter tv series
    [Tags]    web
    OPEN BROWSER    https://www.google.com/search?q=dexter   chrome
    wait until page contains    Dexter (TV series)
    press keys    xpath=//*[@id="rso"]/div[2]/div/div/div/div[1]/a    ENTER
    wait until page contains    Crime drama
    close browser
*** Keywords ***
