*** Settings ***
Library     SeleniumLibrary
Resource    ../resources/pages/home_page.resource
Library    Dialogs

*** Variables ***
${GenderMalePosition}=  1
${GenderFemalePosition}=  2

*** Keywords ***


*** Test Cases ***
TC1: Open Test Automation Practice on Chrome Browser
    Open Test Automation Practice
    Maximize Browser Window

#Fill in Registration information
    Enter UserName         Ana Test
    Validate UserName      Ana Test
    Enter Email            anatest@test.com
    Validate Email         anatest@test.com
    Enter Phone            123456789
    Validate Phone         123456789
    Enter Address          TestxxxxTest
    Validate Address       TestxxxxTest
    Sleep    1s
#Chose Gender
    Chose Gender      ${GenderFemalePosition}
    Sleep    1s
#Check Days of Week (Sunday to Saturday)
    Select Days Of Week    Monday
    Select Days Of Week    Tuesday
    Sleep    3s
    Uncheck All Positions On List    ${list_days}    2    3
    Sleep    3s
    Check All Positions On List    ${list_days}    1    2    5
    Sleep    1s
#Select Country by Position (1=United States, 2=Canada, 3=United Kingdom, 4=Germany, 5=France, 6=Australia
# 7=Japan, 8=China, 9=Brazil, 10=India)
    Select Country    7
    Validate List Element Is Selected By Position    ${drp_country}    7
    Validate List Element Is Not Selected By Position    ${drp_country}    5
#Select Colors (Red, Blue, Green, Yellow, White, Green)
    Check All Content On List    ${list_colors}    Blue    Yellow
    Validate List Elements Are Selected By Content    ${list_colors}    Blue    Yellow
    Validate List Elements Are Not Selected By Content    ${list_colors}    Red
    Sleep    1s
#Select Animals (Cat, Cheetah, Deer, Dog, Elephant, Fox, Giraffe, Lion, Rabbit, Zebra)
    Select Sorted List    Dog
    Select Sorted List    Cat
    Validate List Elements Are Selected By Content    ${list_sorted}    Dog    Cat
    Validate List Elements Are Not Selected By Content    ${list_sorted}    Cheetah    Deer    Zebra
    Sleep    1s
#Validate element from Static Table
    Validate Text On Static Table Element By Row Content And Column Name    ${TableLocator}    Learn JS    Price    300
    Validate Element Is Visible On Static Table By Position    ${TableLocator}    2    1
    Validate Element Is Visible On Static Table By Column Name    ${TableLocator}    2    Author
    Validate Element is Visible on Static Table By Row Content and Column Name    ${TableLocator}    Learn Java    Author
    Validate Element is Visible on Static Table by Row Content and Column Position    ${TableLocator}    Learn Java    1
    Validate Text on Static Table Element by Position    ${TableLocator}    5    1    Master In Selenium
    Validate Text on Static Table Element by Column Name    ${TableLocator}    5    BookName    Master In Selenium
    Validate Text on Static Table Element By Row Content and Column Name    ${TableLocator}    Master In Selenium    BookName    Master In Selenium
    Validate Text on Static Table Element by Row Content and Column Position     ${TableLocator}    Master In Selenium    1    Master In Selenium
    Sleep    1s
#Validate element from Dynamic Table
    Validate Text on Dynamic Table Element by Row Content and Column Position    ${DynamicTableLocator}     Chrome     3
    Validate Element is Visible on Dynamic Table by Position    ${DynamicTableLocator}     3     3
    Validate Element is Visible on Dynamic Table by Column Name    ${DynamicTableLocator}    2     Disk (MB/s)
    Validate Element is Visible on Dynamic Table By Row Content and Column Name    ${DynamicTableLocator}    Firefox    Disk (MB/s)
    Validate Element is Visible on Dynamic Table by Row Content and Column Position    ${DynamicTableLocator}     Internet Explorer    2
    Validate Text on Dynamic Table Element by Position    ${DynamicTableLocator}     2     2
    Validate Text on Dynamic Table Element by Column Name    ${DynamicTableLocator}    3    Disk (MB/s)     \\d+\\.\\d+\\sMB/s

#Datepicker
    Scroll Element Into View    ${CalendarLocator}
    Open Date Picker    ${CalendarLocator}
    Validate Current Day    3
    Click On Day    20
    Open Date Picker    ${CalendarLocator}
    Sleep     2s
    Validate Selected Day    20
    Sleep    1s
    Go To Month And Year    ${CalendarLocator}    February    2025
    Sleep    3s
    Validate That Day Not Exist    30
    Sleep    2s


