*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/page-objects/main-page.robot
Resource    ../Resources/page-objects/edit-topic.robot
*** Keywords ***
Search for Topic
    main-page.Load Wikipedia
    main-page.Verify Page Load
    main-page.Search For Topic
    main-page.Verify Topic Page Load

Try To Edit Topic
    edit-topic.Start Editing Topic
    edit-topic.Notify Login Status
