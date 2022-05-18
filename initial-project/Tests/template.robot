*** Variables ***

*** Test Cases ***
My Test
    [Template]  My Test Template
    One     Two     Three       Four
    Five    Six     Seven       Eight

*** Keywords ***
My Test Template
    [Arguments]  ${ValueOne}  ${ValueTwo}  ${ValueThree}  ${ValueFour}
    Log  ${ValueOne}
    Log  ${ValueTwo}