*** Settings ***
Documentation    This will give some basic info about the test suite
Library    SeleniumLibrary
*** Variables ***

*** Test Cases ***
User must signin to checkout
    [Documentation]    This will give some basic info about the test
    [Tags]    Smoke
    OPEN BROWSER    https://www.amazon.in/    edge
    close browser
*** Keywords ***
