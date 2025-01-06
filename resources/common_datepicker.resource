*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${locatorDatePicker}       //*[@id="ui-datepicker-div"]
${nextMonthButton}         //*[@id="ui-datepicker-div"]//a[@title="Next"]
${previousMonthButton}     //*[@id="ui-datepicker-div"]//a[@title="Prev"]
${datePickerMonth}     //*[@id="ui-datepicker-div"]//*[@class="ui-datepicker-month"]
${datePickerYear}      //*[@id="ui-datepicker-div"]//*[@class="ui-datepicker-year"]
${currentDay}      //*[@id="ui-datepicker-div"]//a[contains(@class, "ui-state-highlight")]
${selectedDay}    //*[@id="ui-datepicker-div"]//a[contains(@class, "ui-state-active")]


&{monthNumbersByName}    January=1    February=2    March=3    April=4    May=5    June=6    July=7    August=8    September=9    October=10    November=11    December=12

*** Keywords ***
Click next Month
    Click Element    ${nextMonthButton}
    
Click previous Month
    Click Element    ${previousMonthButton}

Validate Month and Year
    [Arguments]    ${month_expected}    ${year_expected}
    ${month_displayed}=    Get Text    ${datePickerMonth}
    ${year_displayed}=    Get Text    ${datePickerYear}
    Should Be Equal    ${month_displayed}    ${month_expected}
    Should Be Equal    ${year_displayed}    ${year_expected}

Open Date Picker
    [Arguments]    ${datePickerLocator}
    Click Element    ${datePickerLocator}

Validate Current Day
    [Arguments]    ${expectedDay}
    ${currentDayText}=    Get Text    ${currentDay}
    Should Be Equal    ${currentDayText}    ${expectedDay}

Click on Day
    [Arguments]    ${day}
    Click Element    //*[@id="ui-datepicker-div"]//a[@data-date="${day}"]
    
Validate Selected Day
    [Arguments]    ${expectedDay}
    ${selectedDayText}=    Get Text    ${selectedDay}
    Should Be Equal    ${selectedDayText}    ${expectedDay}

Validate that Day Exist
    [Arguments]    ${day}
    Element Should Be Visible    //*[@id="ui-datepicker-div"]//a[@data-date="${day}"]

Validate that Day not Exist
    [Arguments]    ${day}
    Element Should Not Be Visible    //*[@id="ui-datepicker-div"]//a[@data-date="${day}"]
    
Go To Month And Year
    [Arguments]    ${datePickerLocator}    ${desiredMonth}    ${desiredYear}
    Open Date Picker    ${datePickerLocator}
    ${desiredMonthNumber}=    Get From Dictionary    ${monthNumbersByName}    ${desiredMonth}

    ${currentMonth}=    Get Text    ${datePickerMonth}
    ${currentMonthNumber}=    Get From Dictionary    ${monthNumbersByName}    ${currentMonth}
    ${currentYear}=    Get Text    ${datePickerYear}

    WHILE    int(${desiredYear}) != int(${currentYear}) or int(${desiredMonthNumber}) != int(${currentMonthNumber})

        IF    ( int(${desiredYear}) > int(${currentYear}) ) or ( int(${desiredYear}) == int(${currentYear}) and int(${desiredMonthNumber}) > int(${currentMonthNumber}) )
            Click Next Month
        ELSE
            Click Previous Month
        END

        ${currentMonth}=    Get Text    ${datePickerMonth}
        ${currentMonthNumber}=    Get From Dictionary    ${monthNumbersByName}    ${currentMonth}
        ${currentYear}=    Get Text    ${datePickerYear}
    END

