*** Settings ***
Documentation    Searching a topic and trying to edit it
Resource    ../Resources/Common.robot
Resource    ../Resources/Wikipedia.robot
Test Setup    Begin Web Test
Test Teardown    End Web Test
*** Variables ***

*** Test Cases ***
Should display user not logged in message
    [Documentation]    User should get a prompt stating they are not logged in
    [Tags]    web   smoke
    Wikipedia.Search for Topic
    Wikipedia.Try To Edit Topic

*** Keywords ***