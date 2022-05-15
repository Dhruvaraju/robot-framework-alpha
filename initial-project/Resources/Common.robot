*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Begin Web Test
    OPEN BROWSER    about:blank    chrome

End Web Test
    close browser