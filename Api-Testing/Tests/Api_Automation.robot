*** Settings ***
Documentation    An example test suite for checking an api
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    http://localhost:9090
${GET_URI}    /api/users
${POST_URI}    /api/register
${PUT_URI}    /api/update
${DELETE_URI}    /api/delete
&{INITIAL_REQUEST_BODY}    userName=alpha    email=alpha@alpha.com    password=alpha
&{UPDATED_REQUEST_BODY}    id=1    userName=beta    email=beta@alpha.com    password=beta
&{HEADER}    Content-Type=application/json
*** Test Cases ***
Add an user
    [Documentation]    To add a user to the data base
    [Tags]    POST    DEV
    create session    addUser    ${BASE_URL}
    ${response} =  POST On Session    addUser    ${POST_URI}    json=${INITIAL_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}

Update an user
    [Documentation]    To Update an existing user to the data base
    [Tags]    PUT    DEV
    create session    updateUser    ${BASE_URL}
    ${response} =  PUT On Session    updateUser    ${PUT_URI}    json=${UPDATED_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}

Get all users
    [Documentation]    To get all existing users from data base
    [Tags]    GET    DEV
    create session    getUsers    ${BASE_URL}
    ${response} =  GET On Session    getUsers    ${GET_URI}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}

Delete an user
    [Documentation]    To Delete existing user from the data base
    [Tags]    DELETE    DEV
    create session    deleteUser    ${BASE_URL}
    ${response} =  DELETE On Session    deleteUser    ${DELETE_URI}    json=${UPDATED_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    202

    log    ${response.content}
    log    ${response.headers}
*** Keywords ***
