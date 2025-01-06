*** Settings ***
Library    SeleniumLibrary
Library    Collections
Resource    ../common_list.resource
Resource    ../common_table.resource
Resource    ../common_datepicker.resource

*** Variables ***
${home_url}                  https://testautomationpractice.blogspot.com/
${browser}                   chrome
#Locators Registration
${txt_name}                  //input[@id="name"]
${txt_email}                 //input[@id="email"]
${txt_phone}                 //input[@id="phone"]
${txt_address}               //textarea[@id="textarea"]
#Locators Lists
${list_gender}               //input[@type='radio' and @name='gender']
${list_days}                 //div[contains(@class, 'form-group')][4]//input[@type='checkbox']
${list_week}                 //input[@type="checkbox"]//parent::div

${drp_country}               //*[@id="country"]//child::option
${list_colors}               //*[@id="colors"]//child::option
${list_sorted}               //*[@id="animals"]//child::option

#Other Locators
${chk_sunday}                //*[@id="sunday"]

#Table Locators
${TableLocator}              //table[@name="BookTable"]
${DynamicTableLocator}       //table[@id="taskTable"]

#DatePicker Locator
${CalendarLocator}            //input[@id="datepicker"]


*** Keywords ***
Open Test Automation Practice
    Open Web Browser    ${home_url}    ${browser}

#Fill in Data From User
Enter UserName
    [Arguments]    ${username}
    Input Text    ${txt_name}    ${username}

Validate UserName
    [Arguments]    ${username}
    Textfield Should Contain    ${txt_name}    ${username}    

Enter Email
    [Arguments]    ${email}
    Input Text    ${txt_email}    ${email}
    
Validate Email
    [Arguments]    ${email}
    Textfield Should Contain    ${txt_email}    ${email}

Enter Phone
    [Arguments]    ${phone}
    Input Text    ${txt_phone}    ${phone}
    
Validate Phone
    [Arguments]    ${phone}
    Textfield Should Contain    ${txt_phone}    ${phone}

Enter Address
    [Arguments]    ${address}
    Input Text    ${txt_address}    ${address}
    
Validate Address
    [Arguments]    ${address}
    Textarea Should Contain    ${txt_address}    ${address}
    
Chose Gender
    [Arguments]    ${input_index}
    Click On List By Position      ${list_gender}    ${input_index}

Select Days of Week
    [Arguments]    ${content}
    Click On List By Content      ${list_week}    ${content}

Select Country
    [Arguments]    ${input_index}   
    Click On List By Position     ${drp_country}    ${input_index}

Select Colors
    [Arguments]    ${content}
    Click On List By Content      ${list_colors}    ${content}

Select Sorted List
    [Arguments]    ${content}
    Click On List By Content      ${list_sorted}    ${content}

Get Element from Static Table by Position
    [Arguments]    ${Locator}    ${rowPosition}    ${columnPosition}
    Scroll Element Into View    ${Locator}
    ${cell}=    Get Element On Table By Position    ${Locator}    ${rowPosition}    ${columnPosition}
    ${text}=    Get Text     ${cell}
    RETURN    ${text}

Get Element from Dynamic Table by Position
    [Arguments]    ${Locator}    ${rowPosition}    ${columnPosition}
    Scroll Element Into View    ${Locator}
    Wait Until Page Contains Element    ${Locator}
    ${cell}=    Get Element On Dynamic Table By Position    ${Locator}    ${rowPosition}    ${columnPosition}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

Get Element from Static Table by Column Name
    [Arguments]    ${Locator}    ${rowPosition}    ${columnName}
    Scroll Element Into View    ${Locator}
    ${cell}=    Get Element On Table By Column Name    ${Locator}    ${rowPosition}    ${columnName}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

Get Element from Dynamic Table by Column Name
    [Arguments]    ${Locator}    ${rowPosition}    ${columnName}
    Scroll Element Into View    ${Locator}
    Wait Until Page Contains Element    ${Locator}
    ${cell}=    Get Element On Dynamic Table By Column Name    ${Locator}    ${rowPosition}    ${columnName}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

Get Element from Static Table by Row Content and Column Name
    [Arguments]    ${Locator}    ${rowContent}    ${columnName}
    Scroll Element Into View    ${Locator}
    ${cell}=    Get Element On Table By Row Content And Column Name    ${Locator}    ${rowContent}    ${columnName}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

Get Element from Dynamic Table by Row Content and Column Name
    [Arguments]    ${Locator}    ${rowContent}    ${columnName}
    Scroll Element Into View    ${Locator}
    Wait Until Page Contains Element    ${Locator}
    ${cell}=    Get Element On Dynamic Table By Row Content And Column Name    ${Locator}    ${rowContent}    ${columnName}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}
    
Get Element from Static Table by Row Content and Column Position
    [Arguments]    ${Locator}    ${rowContent}    ${columnPosition}
    Scroll Element Into View    ${Locator}
    ${cell}=    Get Element On Table By Row Content And Column Position    ${Locator}    ${rowContent}    ${columnPosition}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

Get Element from Dynamic Table by Row Content and Column Position
    [Arguments]    ${Locator}    ${rowContent}    ${columnPosition}
    Scroll Element Into View    ${Locator}
    Wait Until Page Contains Element    ${Locator}
    ${cell}=    Get Element On Dynamic Table By Row Content And Column Position    ${Locator}    ${rowContent}    ${columnPosition}
    ${text}=    Get Text    ${cell}
    RETURN    ${text}

