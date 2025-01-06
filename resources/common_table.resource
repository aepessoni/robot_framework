*** Settings ***
Library    SeleniumLibrary
Resource    common_elements.resource
Resource    common_list.resource

*** Variables ***


*** Keywords ***
Count Rows on Table
    [Arguments]    ${Locator}
    ${rows}=    Get Element Count    ${Locator}    
    RETURN    ${rows}
        
Count Columns on Table
    [Arguments]    ${Locator}
    ${columns}=    Get Element Count    ${Locator}
    RETURN    ${columns}
    
Get Header from Table
    [Arguments]    ${Locator}
    ${header_row}    Get WebElements    ${Locator}/*/tr/th
    FOR    ${header}    IN    @{header_row}
        ${header_text}    Get Text    ${header}
        Log    Header: ${header_text}
    END

Find Column Position
    [Arguments]    ${TableLocator}    ${columnName}
    ${columns}=    Get WebElements     ${TableLocator}/*/tr/th
    ${columnPosition}    Set Variable    -1
    FOR    ${index}    ${column}    IN ENUMERATE    @{columns}
        ${currentColumnText}=    Get Text    ${column}
        Log To Console    'Position ${index} => ${currentColumnText}'
        
        IF    '${currentColumnText}' == '${columnName}'
            ${columnPosition}    Set Variable    ${index} + 1
        END
    END
    RETURN    ${columnPosition}

Find Row Position
    [Arguments]    ${TableLocator}    ${rowContent}
    ${rows}=    Get WebElements     ${TableLocator}/*/tr
    FOR    ${index}    ${row}    IN ENUMERATE    @{rows}
        ${currentRowText}=    Get Text    ${row}
        Log To Console    'Position ${index} => ${currentRowText}'
        ${contains}=  Evaluate   "${rowContent}" in """${currentRowText}"""
        IF    '${contains}' == 'True'
            RETURN     ${index} + 1
        END
    END
    RETURN    -1
    
Table Has Header
    [Arguments]    ${TableLocator}
    ${headerRows}=    Get Webelements    ${TableLocator}/*/tr/th
    ${rowsLength}=    Get Length    ${headerRows}
    IF    ${rowsLength} > 0
        RETURN    True
    ELSE
        RETURN    False
    END
    
Store Table Data into a List
    [Arguments]    ${Locator}    
    ${rows}    Get Element Count    ${Locator}
    ${table_data}    Create List
    FOR    ${r}    IN RANGE    2    ${rows+1}
        ${row_data}    Create List
        ${columns}    Get Element Count    ${Locator}/*/tr[position()=${r}]/td | ${Locator}/*/tr[position()=${r}]/th
        FOR    ${c}    IN RANGE    1    ${columns+1}
            ${cell}    Get Text    ${Locator}/*/tr[${r}]/td[position()=${c}] | ${Locator}/*/tr[${r}]/th[position()=${c}]
            Append To List    ${row_data}    ${cell}
        END
        Append To List    ${table_data}    ${row_data}
    END
    Log    ${table_data}
    
Find Row with Multiple Conditions
    [Arguments]    ${TableLocator}    ${condition1}    ${condition2}
    ${rows}    Get Element Count    ${TableLocator}/*/tr
    FOR    ${index}    IN RANGE    2    ${rows+1}
        ${cond1}    Get Text    ${TableLocator}/*/tr[position()=${index}]/td[position()=1] | ${TableLocator}/*/tr[position()=${index}]/th[position()=1]
        ${cond2}    Get Text    ${TableLocator}/*/tr[position()=${index}]/td[position()=2] | ${TableLocator}/*/tr[position()=${index}]/th[position()=2]
        Run Keyword If    '${cond1}' == '${condition1}' and '${cond2}' == '${condition2}'    
        Log To Console    Found ${condition1}, ${condition2} at Row ${index}
    END

        
###Table with header###

Get Element on Table by Position
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnPosition}
    TRY
        ${cell}=    Get WebElement     ${TableLocator}/*/tr[position()=${rowPosition}]/td[position()=${columnPosition}] | ${TableLocator}/*/tr[position()=${rowPosition}]/th[position()=${columnPosition}]
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${TableLocator} on row ${rowPosition} and column ${columnPosition}: ${error}
    END
    
    RETURN    ${cell}

Get Element on Table by Column Name
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnName}
    TRY
        ${columnPosition}=    Find Column Position    ${TableLocator}    ${columnName}
        Log To Console    'Found column at position: ${columnPosition}'
        ${element_position}=    Get Element On Table By Position    ${TableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${TableLocator} on row ${rowPosition} and column ${columnName}: ${error}
    END

    RETURN    ${element_position}

Get Element on Table by Row Content and Column Name
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnName}
    TRY
        ${rowPosition}=    Find Row Position    ${TableLocator}    ${rowContent}
        Log To Console    'Found row at position: ${rowPosition}'
        ${columnPosition}=    Find Column Position    ${TableLocator}    ${columnName}
        Log To Console    'Found column at position: ${columnPosition}'
        ${element_position}=    Get Element On Table By Position    ${TableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${TableLocator} on row ${rowContent} and column ${columnName}: ${error}
    END

    RETURN    ${element_position}


Get Element on Table by Row Content and Column Position
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnPosition}
    TRY
        ${rowPosition}=    Find Row Position    ${TableLocator}    ${rowContent}
        Log To Console    'Found row at position: ${rowPosition}'
        ${element_position}=    Get Element On Table By Position    ${TableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${TableLocator} on row ${rowContent} and column ${columnPosition}: ${error}
    END
    
    RETURN    ${element_position}


###Table no header###

Get Element on Dynamic Table by Position
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    TRY
        ${cell}=    Get WebElement     ${DynamicTableLocator}/*/tr[position()=${rowPosition}]/td[position()=${columnPosition}] | ${DynamicTableLocator}/*/tr[position()=${rowPosition}]/th[position()=${columnPosition}]
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${DynamicTableLocator} on row ${rowPosition} and column ${columnPosition}: ${error}
    END
    
    RETURN    ${cell}


Get Element on Dynamic Table by Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnName}
    TRY
        ${columnPosition}=    Find Column Position    ${DynamicTableLocator}    ${columnName}
           ${hasHeader}=    Table Has Header    ${DynamicTableLocator}
        IF    '${hasHeader}' == 'True'
            ${rowPosition}=    Evaluate    ${rowPosition} - 1
            Log To Console    'Table has header, changing row position to ${rowPosition}'
        END
        Log To Console    'Found column at position: ${columnPosition}'
        ${element_position}=    Get Element On Dynamic Table By Position    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${DynamicTableLocator} on row ${rowPosition} and column ${columnName}: ${error}
    END
        
    RETURN    ${element_position}

Get Element on Dynamic Table by Row Content and Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnName}
    TRY
        ${rowPosition}=    Find Row Position    ${DynamicTableLocator}    ${rowContent}
        ${hasHeader}=    Table Has Header    ${DynamicTableLocator}

        IF    '${hasHeader}' == 'True'
            ${rowPosition}=    Evaluate    ${rowPosition} - 1
            Log To Console    'Table has header, changing row position to ${rowPosition}'
        END

        Log To Console    'Found row at position: ${rowPosition}'
        ${columnPosition}=    Find Column Position    ${DynamicTableLocator}    ${columnName}
        Log To Console    'Found column at position: ${columnPosition}'
        ${element_position}=    Get Element On Dynamic Table By Position    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${DynamicTableLocator} on row ${rowContent} and column ${columnName}: ${error}
    END
    
    RETURN    ${element_position}


Get Element on Dynamic Table by Row Content and Column Position
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnPosition}
    TRY
        ${rowPosition}=    Find Row Position    ${DynamicTableLocator}    ${rowContent}
            ${hasHeader}=    Table Has Header    ${DynamicTableLocator}
        IF    '${hasHeader}' == 'True'
            ${rowPosition}=    Evaluate    ${rowPosition} - 1
            Log To Console    'Table has header, changing row position to ${rowPosition}'
        END
            Log To Console    'Found row at position: ${rowPosition}'
        ${element_position}=    Get Element On Dynamic Table By Position    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    EXCEPT    AS    ${error}
        Fail    Could not find element on table ${DynamicTableLocator} on row ${rowContent} and column ${columnPosition}: ${error}
    END
    
    RETURN    ${element_position}

#Table Validation#
#Text

Validate Text on Static Table Element by Position
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnPosition}    ${expected_text} 
    ${element}=     Get Element on Table by Position    ${TableLocator}    ${rowPosition}    ${columnPosition}
    Validate Text On Element    ${element}    ${expected_text}

Validate Text on Static Table Element by Column Name
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnName}    ${expected_text}
    ${element}=    Get Element on Table by Column Name    ${TableLocator}    ${rowPosition}    ${columnName}
    Validate Text On Element    ${element}    ${expected_text}

Validate Text on Static Table Element By Row Content and Column Name
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnName}    ${expected_text}
    ${element}=    Get Element on Table by Row Content and Column Name    ${TableLocator}    ${rowContent}    ${columnName}
    Validate Text On Element    ${element}    ${expected_text}

Validate Text on Static Table Element by Row Content and Column Position
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnPosition}    ${expected_text}
    ${element}=    Get Element on Table by Row Content and Column Position    ${TableLocator}    ${rowContent}    ${columnPosition}
    Validate Text On Element    ${element}    ${expected_text}

Validate Text on Dynamic Table Element by Position
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    ${element}=     Get Element on Dynamic Table by Position    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    Element Should Be Visible    ${element}

Validate Text on Dynamic Table Element by Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnName}    ${regex}
    ${element}=    Get Element on Dynamic Table by Column Name    ${DynamicTableLocator}    ${rowPosition}    ${columnName}
    ${content}=    Get Text    ${element}
    Should Match Regexp    ${content}    ${regex}

Validate Text on Dynamic Table Element By Row Content and Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnName}    ${regex}
    ${element}=    Get Element on Dynamic Table by Row Content and Column Name    ${DynamicTableLocator}    ${rowContent}    ${columnName}
    ${content}=    Get Text    ${element}
    Should Match Regexp    ${content}    ${regex}

Validate Text on Dynamic Table Element by Row Content and Column Position
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnPosition}
    ${element}=    Get Element on Dynamic Table by Row Content and Column Position    ${DynamicTableLocator}    ${rowContent}    ${columnPosition}
    Element Should Be Visible    ${element}
    

#Visible

Validate Element is Visible on Static Table by Position
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnPosition}
    ${element}=     Get Element on Table by Position    ${TableLocator}    ${rowPosition}    ${columnPosition}
    Validate That Element Is Visible    ${element}

Validate Element is Visible on Static Table by Column Name
    [Arguments]    ${TableLocator}    ${rowPosition}    ${columnName}
    ${element}=    Get Element on Table by Column Name    ${TableLocator}    ${rowPosition}    ${columnName}
    Validate That Element Is Visible    ${element}
    
Validate Element is Visible on Static Table By Row Content and Column Name
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnName}
    ${element}=    Get Element on Table by Row Content and Column Name    ${TableLocator}    ${rowContent}    ${columnName}
    Validate That Element Is Visible    ${element}
    
Validate Element is Visible on Static Table by Row Content and Column Position
    [Arguments]    ${TableLocator}    ${rowContent}    ${columnPosition}
    ${element}=    Get Element on Table by Row Content and Column Position    ${TableLocator}    ${rowContent}    ${columnPosition}
    Validate That Element Is Visible    ${element}


Validate Element is Visible on Dynamic Table by Position
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    ${element}=     Get Element on Dynamic Table by Position    ${DynamicTableLocator}    ${rowPosition}    ${columnPosition}
    Validate That Element Is Visible    ${element}

Validate Element is Visible on Dynamic Table by Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowPosition}    ${columnName}
    ${element}=    Get Element on Dynamic Table by Column Name    ${DynamicTableLocator}    ${rowPosition}    ${columnName}
    Validate That Element Is Visible    ${element}
    
Validate Element is Visible on Dynamic Table By Row Content and Column Name
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnName}
    ${element}=    Get Element on Dynamic Table by Row Content and Column Name    ${DynamicTableLocator}    ${rowContent}    ${columnName}
    Validate That Element Is Visible    ${element}
    
Validate Element is Visible on Dynamic Table by Row Content and Column Position
    [Arguments]    ${DynamicTableLocator}    ${rowContent}    ${columnPosition}
    ${element}=    Get Element on Dynamic Table by Row Content and Column Position    ${DynamicTableLocator}    ${rowContent}    ${columnPosition}
    Validate That Element Is Visible   ${element}