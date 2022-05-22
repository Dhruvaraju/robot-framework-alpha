### Required Dependencies Installation

Installations:

- robotframework
- robotframework-requests
- robotframework-jsonlibrary

```dos
pip install robotframework # To Install
pip install --upgrade robotframework # To Upgrade
pip install robotframework==5.0.0 #To install a specific version
pip uninstall robotframework #To uninstall
pip show robotframework # To show details of robot framework
pip check robotframework #To see if robot framework is installed
```

`pip list` will show list of dependencies installed.

> Use pip install to install all the dependencies that are mentioned above.

Use the project https://github.com/Dhruvaraju/api_for_test_automation for an example api

To make rest calls we need to use `Library RequestsLibrary`

### Making Get call

- Consider an api http://localhost:9090/api/users, which gives list of users.
- In the above api endpoint `http://localhost:9090` is server url
- `/api/users` is the get resource uri.
- To initiate a connection we need to use a keyword `create session` which needs server address as an input parameter and name of session

```robot
create session  getUsers http://localhost:9090
```

- In the above example `getUsers` is the name of session.
- `http://localhost:9090` is server address.

- Now we need to make a get call to do it we need to use a keyword `GET on session`
- It Takes the session created in the above step and the get resource uri as input and will return a response
- We need to pass a header which has Content-Type=application/json as a dictionary
- `&{headers}= create a dictionary Content-Type=application/json`

```robot
${response} =  GET on session  getUsers  /api/users  headers=${headers}
```

- The response will have
  - status code as response.status_code
  - response body as response.content
  - response headers as response.headers

So now we can compare the values for validations as below.

```robot
Get all users
    [Documentation]    To get all existing users from data base
    [Tags]    GET    DEV
    create session    getUsers    ${BASE_URL}
    ${response} =  GET On Session    getUsers    ${GET_URI}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}
```

### making a post call

- Every thing will be same as GET call but we will pass request body as input parameter
- We will use `GET on session`

```robot
Add an user
    [Documentation]    To add a user to the data base
    [Tags]    POST    DEV
    create session    addUser    ${BASE_URL}
    ${response} =  POST On Session    addUser    ${POST_URI}    json=${INITIAL_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}
```

Similar to post we can make a put and delete calls

```robot
Update an user
    [Documentation]    To Update an existing user to the data base
    [Tags]    PUT    DEV
    create session    updateUser    ${BASE_URL}
    ${response} =  PUT On Session    updateUser    ${PUT_URI}    json=${UPDATED_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    200

    log    ${response.content}
    log    ${response.headers}
```

Delete call

```robot
Delete an user
    [Documentation]    To Delete existing user from the data base
    [Tags]    DELETE    DEV
    create session    deleteUser    ${BASE_URL}
    ${response} =  DELETE On Session    deleteUser    ${DELETE_URI}    json=${UPDATED_REQUEST_BODY}    headers=${HEADER}
    ${status} =    convert to string    ${response.status_code}
    should be equal    ${status}    202

    log    ${response.content}
    log    ${response.headers}
```
