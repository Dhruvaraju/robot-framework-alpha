# robot-framework-alpha

- [robot-framework-alpha](#robot-framework-alpha)
    - [Installing python and pip](#installing-python-and-pip)
    - [Installing robot framework and selenium library](#installing-robot-framework-and-selenium-library)
    - [Selenium drivers for different browsers](#selenium-drivers-for-different-browsers)
    - [Folder Structure for scripts](#folder-structure-for-scripts)
    - [Structure of a Script](#structure-of-a-script)
    - [First Test Script](#first-test-script)
    - [Creating a sample test script with locators](#creating-a-sample-test-script-with-locators)
    - [Script Running Options](#script-running-options)
    - [Running Multiple test suits](#running-multiple-test-suits)
    - [Running a single test case](#running-a-single-test-case)
    - [Creating custom keywords](#creating-custom-keywords)
    - [Breaking down test to keywords](#breaking-down-test-to-keywords)
    - [Moving keywords to resources folder](#moving-keywords-to-resources-folder)
    - [Adding setup and teardown](#adding-setup-and-teardown)
    - [Creating Page Objects](#creating-page-objects)
    - [Adding Gherkin](#adding-gherkin)
    - [Adding Variables](#adding-variables)

### Installing python and pip

- Download python from https://www.python.org/
- Install it by double clicking it.
- To verify installation use `python --version` and `pip --version` these will display corresponding versions.
- To upgrade pip version use the command

```dos
python -m pip install --upgrade pip
```

### Installing robot framework and selenium library

To install robotframework

```
pip install robotframework
```

To install robotframework-seleniumlibrary

```
pip install robotframework-seleniumlibrary
```

> https://pypi.org/ is a python package manager library. which will help in getting different libraries.

### Selenium drivers for different browsers

- Navigate to https://www.selenium.dev/
- Goto downloads, check the browser versions and download corresponding versions.
- Add a folder of your choice and keep all the drivers in it.
- Add the folder to path variable in windows environment variables.

Download and install pycharm community edition and add intellibot plugin (Choose the most recent one from millennial media)

### Folder Structure for scripts

- In the main folder or project folder we will have
  - **tests** folder for holding test scripts
  - **resources** for holding test resources
  - **results** to hold the results of the test.

### Structure of a Script

- The following sections will be part of robot framework script

  - Settings
    - Documentation Some info about the suite
    - Library Some library name
    - Resource Some resource_file.robot
    - Suite Setup/Suite Teardown Some Keyword
    - Test Setup/Test Teardown Some Keyword
    - Test Timeout X
  - Variables
  - Test cases
    - [Documentation] Some info about the test
    - [Tags] Tag1 Tag2
    - [Timeout] X
  - Keywords (optional)

  > List of libraries for robot framework available at https://forum.robotframework.org/c/libraries/9

All robot scripts have extension as `.robot`, after every keyword we need to provide 2 spaces

### First Test Script

- Under setting we need to add
  - Documentation add basic info about the test case
  - Library add the library that you are using to run this script
- Do not add anything under variables
- Under Test case use the following test case
  - Update the test case name initially
  - [Documentation] This will provide documentation about the test script.
  - [Tags] add the test tags
  - Open Browser is keyword to open a browser (takes url and browser as input)
  - close browser is a keyword to close a browser
- Under Keywords no need to mention anything

```
*** Settings ***
Documentation    This will give some basic info about the test suite
Library    SeleniumLibrary
*** Variables ***

*** Test Cases ***
User must sign-in to checkout
    [Documentation]    This will give some basic info about the test
    [Tags]    Smoke
    OPEN BROWSER    https://www.amazon.in/    chrome
    close browser
*** Keywords ***
```

- To run a test script use the command `robot <<test_script_name.robot>>`
- To run a test script and place results in a specific folder `robot -d <<folder_path>> <<test_script_name.robot>>`

```
robot tests/Amazon.robot #for the location where script is present
robot -d results tests/Amazon.robot #results is the folder where the results will be stored
```

> Its a best practice to create a manual test scenario before writing automation test script.

> To know list of all key words required to write tests navigate to library documentation
> Example for SeleniumLibrary keywords https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html

### Creating a sample test script with locators

- The ID or xpath or css selector of an element is called as locator.
- Navigate a desired webpage in chrome, right click on the element you want to find a locator for.
- Click on inspect in developer tools the section will be highlighted.
- Right click on the section in dev tools, and go to copy, it will show options to copy as xpath css and few other things.
- We can now use this in conjunction with different keywords from different libraries in robot framework.

```robot
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
```

### Script Running Options

To run a robot script from **pycharm** open terminal then run any of the following commands.
To run **using command prompt** navigate to the folder and then run the following commands.

```dos
robot path-to-test-script.robot #To run from the location where script is present
robot -d results path-to-test-script.robot # to run and place results in a folder called results
robot -d results --include smoke path-to-test-script.robot # place results in results folder and run only smoke tests
robot -d <<Provide-location-to-remote-results-directory>> -i smoke path-to-test-script.robot # run and place results in a different directory, run only smoke tests
```

**Running using Batch file**
Add the following to a batch script.

```dos
@echooff
cd <<folder where script project is present>>
call robot path-to-test-script.robot
call robot -d results path-to-test-script.robot
call robot -d results --include smoke path-to-test-script.robot
call robot -d <<Provide-location-to-remote-results-directory>> -i smoke path-to-test-script.robot
```

> To schedule the a robot script run, add the batch script created earlier and assign time-slot.
> With windows scheduler.

### Running Multiple test suits

- Run the robot command which you usually use instead of pointing it to a script file just mention the folder name.
- For example if you want to run all the test in tests folder use

```
robot -d results tests
```

- If you like to give a name to the test suite you are running you can trigger it as

```
robot -d results -N "Regression test suite" tests
```

- If you like to run tests present in a sub folder use

```
robot -d results -N "Regression test suite" "tests/folder for some tests"
```

### Running a single test case

- use the absolute name or '-t' switch with test name

```
robot -d results <<absolute-path-for-test-case>>
robot -d results -t "name-of-test-case" tests # runs a particular test with name specified in test folder
robot -d results -i "mention-tag-name" tets # runs with specific tag name in tests folder
```

> We can use multiple '-t' or '-i' switches in same execution.

### Creating custom keywords

- We can create a custom keywords by defining them under keywords
- In the below example

  - Do Something
  - Do Something Else
  - Do Another Thing
    are custom defined key words, their implementation in mentioned under the keywords section.

- While executing this script the keywords will be displayed as test steps.
- To see the execution keywords wee need to drill down the tree view in results (log.html)

```robot
*** Settings ***s

*** Variables ***

*** Test Cases ***
Test case 01
    Do Something
    Do Something Else

Test Case 02
    Do Something
    Do Another Thing

*** Keywords ***
Do Something
    log    I am doing something

Do Something Else
    log    I am doing something else

Do Another Thing
    log     I am doing another thing
```

### Breaking down test to keywords

**Example**

```robot

*** Settings ***
Documentation    Searching a topic and trying to edit it
Library    SeleniumLibrary
*** Variables ***

*** Test Cases ***
Should display user not logged in message
    [Documentation]    User should get a prompt stating they are not logged in
    [Tags]    web   smoke
    # Begin Web Test
    OPEN BROWSER    about:blank    chrome

    # Search for Topic
    go to    https://en.wikipedia.org/wiki/Main_Page
    wait until page contains    Main Page
    input text    id=searchInput    robot framework
    click button    id=searchButton
    wait until page contains    Robot Framework is a generic test automation

    # Try To Edit Topic
    click link    xpath=//*[@id="ca-edit"]/a
    wait until page contains    You are not logged in.

    # End Web Test
    close browser
*** Keywords ***
```

- Every comment can be converted into a keyword for that
- Move the text in comment to keywords section making them as keywords
- Place the keywords used under the comments as keyword implementation
- Refer to the below example

```robot
*** Settings ***
Documentation    Searching a topic and trying to edit it
Library    SeleniumLibrary
*** Variables ***

*** Test Cases ***
Should display user not logged in message
    [Documentation]    User should get a prompt stating they are not logged in
    [Tags]    web   smoke
    Begin Web Test
    Search for Topic
    Try To Edit Topic
    End Web Test

*** Keywords ***
Begin Web Test
    OPEN BROWSER    about:blank    chrome

Search for Topic
    go to    https://en.wikipedia.org/wiki/Main_Page
    wait until page contains    Main Page
    input text    id=searchInput    robot framework
    click button    id=searchButton
    wait until page contains    Robot Framework is a generic test automation

Try To Edit Topic
    click link    xpath=//*[@id="ca-edit"]/a
    wait until page contains    You are not logged in.

End Web Test
    close browser
```

> Now documentation in log.html will display only keywords as steps.

### Moving keywords to resources folder

We can split the keywords into different files under resources like
Common.robot for common functions

```robot
*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Begin Web Test
    OPEN BROWSER    about:blank    chrome

End Web Test
    close browser
```

Wikipedia.robot for wikipedia related interaction

```robot
*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Search for Topic
    go to    https://en.wikipedia.org/wiki/Main_Page
    wait until page contains    Main Page
    input text    id=searchInput    robot framework
    click button    id=searchButton
    wait until page contains    Robot Framework is a generic test automation

Try To Edit Topic
    click link    xpath=//*[@id="ca-edit"]/a
    wait until page contains    You are not logged in.
```

Now the test script will look as below

```robot
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
```

### Adding setup and teardown

- We have two types of setup and teardown

  - test
  - suite

- Test setup will run before every test-case
- Test teardown will run after every test-case

- Suite Setup will run before all test cases.
- Suite Teardown will run after all test cases are completed running.

> We can open a browser in test setup and close it in test teardown
> Generally Suite setup is used to add test data and suite teardown is used to remove test data from a source.

Test or suite setup and teardown will be mentioned under settings

```robot
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
```

### Creating Page Objects

- We can keep page related interactions into a single file.
- We can even drill down them to be a portion of page like nav-bar interactions or some other section.
- Example is shown below

```robot
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
```

page object : main-topic

```robot
*** Settings ***
Library    SeleniumLibrary
*** Keywords ***
Load Wikipedia
    go to    https://en.wikipedia.org/wiki/Main_Page

Verify Page Load
    wait until page contains    Main Page

Search For Topic
    input text    id=searchInput    robot framework
    click button    id=searchButton

Verify Topic Page Load
    wait until page contains    Robot Framework is a generic test automation
```

page object : edit-topic

```robot
*** Settings ***
Library    SeleniumLibrary

*** Keywords ***
Start Editing Topic
    click link    xpath=//*[@id="ca-edit"]/a

Notify Login Status
    wait until page contains    You are not logged in.
```

### Adding Gherkin

- Gherkin uses the following phrases, like given, and, when , then
- Given AND are used for preconditions
- When is used for actual test case test
- Then will be used to check expected test result.

### Adding Variables

- Scalar variables or variable with single value can be added as `${variable_name} = vale of it`
- List variables are provided as `@{list_variable} = var01 var02 var03'
- To Return value from list variable use `${list_variable}[0]`
- To get value of scalar variable use `${variable_name}`
- For passing variables to keyword use as below

```robot
*** Test Cases ***
    Begin Web Test    https://www.google.com    chrome
*** Keywords ***
Begin Web Test
    [Arguments]    ${url}    ${BROWSER}
    open browser    ${url}    ${BROWSER}
    close browser

```

Few more examples of variables are mentioned below.

```robot
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
```
