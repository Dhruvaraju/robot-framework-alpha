*** Settings ***
Library    SeleniumLibrary
*** Variables ***
# Browser can now be passed to other sections
# Varibales mentined here are generally global variables
# We can also assign a variable in test case section
${BROWSER} =    chrome
@{LIST_VARIABLE} =    alpha    beta    gamma
*** Test Cases ***
Open a browser for test
    OPEN BROWSER    about:blank    ${BROWSER}
    ${BROWSER} =    Set Variable    firefox
    log    ${BROWSER}
    log    ${LIST_VARIABLE}[0]
    log    ${LIST_VARIABLE}[1]
    log    ${LIST_VARIABLE}[2]
    ${test_var} =    Set Variable    non global variable value
    log    ${test_var}
    close browser
    Begin Web Test    https://www.google.com    chrome
*** Keywords ***
Begin Web Test
    [Arguments]    ${url}    ${BROWSER}
    open browser    ${url}    ${BROWSER}
    close browser
