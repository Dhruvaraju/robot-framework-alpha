*** Settings ***
Documentation    Searching a topic and trying to edit it
Resource    ../Resources/Common.robot
Resource    ../Resources/Wikipedia.robot
*** Variables ***

*** Test Cases ***
Should display user not logged in message
    [Documentation]    User should get a prompt stating they are not logged in
    [Tags]    web   smoke
    Common.Begin Web Test
    Wikipedia.Search for Topic
    Wikipedia.Try To Edit Topic
    Common.End Web Test

*** Keywords ***