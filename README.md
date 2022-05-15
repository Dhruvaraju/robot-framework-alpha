# robot-framework-alpha

- [robot-framework-alpha](#robot-framework-alpha)
    - [Installing python and pip](#installing-python-and-pip)
    - [Installing robot framework and selenium library](#installing-robot-framework-and-selenium-library)
    - [Selenium drivers for different browsers](#selenium-drivers-for-different-browsers)
    - [Folder Structure for scripts](#folder-structure-for-scripts)
    - [Structure of a Script](#structure-of-a-script)
    - [First Test Script](#first-test-script)
    - [Creating a sample test script with locators](#creating-a-sample-test-script-with-locators)

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