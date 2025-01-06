*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
#Locators
${name}        //input[@id="name"]
${email}       //input[@id="email"]
${phone}       //input[@id="phone"]
${address}     //textarea[@id="textarea"]

*** Keywords ***
Open Web Browser
    [Arguments]    ${SiteUrl}     ${Browser}
    Open Browser    ${SiteUrl}    ${Browser}

Click on Element
    [Arguments]    ${Locator}
    Click Element    ${Locator}

Validate Text on Element
    [Arguments]    ${Locator}    ${expected_text}
    Element Text Should Be    ${Locator}    ${expected_text}

Validate that Element is Visible
    [Arguments]    ${Locator}
    Element Should Be Visible    ${Locator}

Validate that Element Exist
    [Arguments]    ${Locator}
#    Page Should Contain Element    ${Locator}
    ${status}=    Run Keyword And Return Status    Page Should Contain Element    ${Locator}
    Run Keyword If    not ${status}    Fail    Custom Error: The element with locator "${Locator}" is either not present or not visible on the page.
    
Type on Element
    [Arguments]    ${Locator}    ${Text}
    Input Text    ${Locator}    ${Text}
    
Select Element
    [Arguments]    ${Locator}
    Click Element       ${Locator}
    
Check on Element
    [Arguments]    ${Locator}
    ${selected}=    Is Checkbox Selected    ${Locator}
    IF    '${selected}' == 'False'
       Click Element    ${Locator}
    END
    
Uncheck on Element
    [Arguments]    ${Locator}
    ${selected}=    Is Checkbox Selected    ${Locator}
    Log To Console    'Is Selected? ${selected}'
     IF    '${selected}' == 'True'
       Click Element    ${Locator}
    END

Validate Checkbox not Selected
    [Arguments]    ${Locator}
    ${selected}=    Run Keyword And Return Status    Checkbox Should Not Be Selected    ${Locator}
    RETURN    ${selected}

Validate Checkbox is Selected
    [Arguments]    ${Locator}
    Checkbox Should Be Selected    ${Locator}

Is Checkbox Selected
    [Arguments]    ${Locator}
    ${selected}=    Run Keyword And Return Status    Checkbox Should Be Selected    ${Locator}
    RETURN    ${selected}
    
Click on Element and Wait
    [Arguments]    ${Locator}    ${TimeInSeconds}
    Click Element    ${Locator}
    Sleep    ${TimeInSeconds} 
    
Wait and Click on Element
    [Arguments]    ${Locator}    ${TimeInSeconds}
    Sleep    ${TimeInSeconds}
    Click Element    ${Locator}
    
Wait Until Element is Visible
    [Arguments]    ${Locator}    ${TimeInSeconds}
    Wait Until Page Contains Element    ${Locator}    ${TimeInSeconds}
        
Click on Element Error Message
    [Arguments]    ${Locator}    ${ErrorMessage}
    ${passed}=    Run Keyword And Return Status    Click Element    ${Locator}
    Run Keyword If  '${passed}' == False    Fail ${ErrorMessage}













