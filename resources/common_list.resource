*** Settings ***
Library    SeleniumLibrary
Resource    common_elements.resource

*** Variables ***


*** Keywords ***
Click on List by Position
    [Arguments]    ${Locator}    ${position} 
    ${element}=     Get On List By Position    ${Locator}    ${Position}
    Click On Element    ${element}
    
Click on List by Content
    [Arguments]    ${Locator}    ${content}
    ${element}=    Get On List By Content    ${Locator}    ${content}
    Click On Element    ${element}

Type on List by Position
    [Arguments]    ${Locator}    ${position}    ${text}
    ${elements}=    Get On List By Position    ${Locator}    ${Position}    
    Type on Element     ${elements}    ${Text}
    
Type on List by Content
    [Arguments]    ${Locator}    ${content}    ${text}
    ${elements}=    Get On List By Content    ${Locator}    ${content}    
    Type On Element    ${elements}    ${text}

Check on List by Position
    [Arguments]    ${Locator}    ${position}
    ${element}=     Get On List By Position    ${Locator}    ${Position}
    Check On Element    ${element}
    
Check on List by Content   
    [Arguments]    ${Locator}    ${content}
    ${element}=     Get On List By Content    ${Locator}    ${content}
    Check On Element    ${element}

Uncheck on List by Position
    [Arguments]    ${Locator}    ${position}
    ${element}=     Get On List By Position    ${Locator}    ${position}
    Uncheck On Element    ${element}

Uncheck on List by Content
    [Arguments]    ${Locator}    ${content}
    ${element}=     Get On List By Content    ${Locator}    ${content}
    Uncheck On Element    ${element}

Check All Positions on List
    [Arguments]    ${Locator}    @{positions}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${position}    IN    @{positions}
        ${new_position}=    Convert To Integer    ${position}
        ${element}=    Get From List    ${elements}    ${new_position -1}
        Check On Element    ${element}
    END

Check All Content on List
    [Arguments]    ${Locator}    @{values}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${value}    IN    @{values}
        FOR    ${element}  IN    @{elements}
        ${text}=    Get Text    ${element}
            IF    '${text}' == '${value}'
                Check On Element    ${element}
            END
        END
    END

Uncheck All Positions on List
      [Arguments]    ${Locator}    @{positions}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${position}    IN    @{positions}
        ${new_position}=    Convert To Integer    ${position}
        ${element}=    Get From List    ${elements}    ${new_position -1}
        Uncheck On Element    ${element}
    END

Uncheck All Content on List
    [Arguments]    ${Locator}    @{values}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${value}    IN    @{values}
        FOR    ${element}  IN    @{elements}
        ${text}=    Get Text    ${element}
            IF    '${text}' == '${value}'
                Uncheck On Element    ${element}
            END
        END
    END

Get on List by Position
    [Arguments]    ${Locator}    ${position}
    ${elements}=    Get WebElements    ${Locator}
    ${new_position}=    Convert To Integer    ${position}
    ${element}=    Get From List    ${elements}    ${new_position -1}
    RETURN    ${element}

    
Get on List by Content
    [Arguments]    ${Locator}    ${content}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${element}  IN    @{elements}
        ${text}=    Get Text    ${element}
        Log To Console    ${text}
        IF    '${text}' == '${content}'
            RETURN    ${element}
        END
    END
    
    Fail    'Could not find element with content ${content}'
    
#position

Validate Text on List Element by Position
    [Arguments]    ${Locator}    ${Position}    ${expected_text} 
    ${element}=     Get On List By Position    ${Locator}    ${Position}
    Validate Text On Element    ${element}    ${expected_text}

Validate that List Element is Visible by Position
    [Arguments]    ${Locator}    ${position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    Validate That Element Is Visible    ${element}

Validate that List Element Exist by Position
    [Arguments]    ${Locator}    ${Position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    Validate That Element Exist    ${element}

Validate that List Element is Checked by Position
    [Arguments]    ${Locator}    ${Position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    Is Checkbox Selected    ${element}

Validate that List Element is not Checked by Position
    [Arguments]    ${Locator}    ${Position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    Validate Checkbox Not Selected    ${element}

Validate List Element is Selected by Position
    [Arguments]    ${Locator}    ${Position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    ${selected}=    Get Element Attribute    ${element}    selected
    IF    '${selected}' != 'true'
        Fail    "Expected element on list ${Locator} at position ${Position} to be selected but was not"
    END

Validate List Element is not Selected by Position
    [Arguments]    ${Locator}    ${Position}
    ${element}=    Get On List By Position    ${Locator}    ${Position}
    ${selected}=    Get Element Attribute    ${element}    selected
    IF    '${selected}' == 'true'
        Fail    "Expected element on list ${Locator} at position ${Position} to not be selected but was selected"
    END


#by content

Validate Text on List Element by Content
    [Arguments]    ${Locator}    ${Content}    ${expected_text}
    ${element}=    Get On List By Content    ${Locator}    ${Content}
    Validate Text On Element    ${element}    ${expected_text}

Validate that List Element is Visible by Content
    [Arguments]    ${Locator}    ${Content}
    ${element}=    Get On List By Content    ${Locator}    ${Content}
    Validate That Element Is Visible   ${element}

Validate that List Element Exist by Content
    [Arguments]    ${Locator}    ${Content}
    ${element}=    Get On List By Content    ${Locator}    ${Content}
    Validate That Element Exist    ${element}

Validate that List Element is Checked by Content
    [Arguments]    ${Locator}    ${Content}
    ${element}=    Get On List By Content    ${Locator}    ${Content}
    Is Checkbox Selected    ${element}

Validate that List Element is not Checked by Content
    [Arguments]    ${Locator}    ${Content}
    ${element}=    Get On List By Content    ${Locator}    ${Content}
    Validate Checkbox Not Selected    ${element}

Validate List Elements are Selected by Content
    [Arguments]    ${Locator}    @{values}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${value}    IN    @{values}
        ${element_found}    Set Variable    false
        FOR    ${element}  IN    @{elements}
            ${text}=    Get Text    ${element}
            IF    '${text}' == '${value}'
                ${element_found}    Set Variable    true
                
                ${selected}=    Get Element Attribute    ${element}    selected
                IF    '${selected}' != 'true'
                    Fail    "Expected element on list ${Locator} with value '${value}' to be selected but was not"
                END
            END
        END
        
        IF   '${element_found}' == 'false'
            Fail     "Expected element on list ${Locator} with value '${value}' to be selected, but element was not found"
        END
    END


Validate List Elements are not Selected by Content
    [Arguments]    ${Locator}    @{values}
    ${elements}=    Get Webelements    ${Locator}
    FOR    ${value}    IN    @{values}
        ${element_found}    Set Variable    false
        FOR    ${element}  IN    @{elements}
            ${text}=    Get Text    ${element}
            IF    '${text}' == '${value}'
                ${element_found}    Set Variable    true

                ${selected}=    Get Element Attribute    ${element}    selected
                IF    '${selected}' == 'true'
                    Fail    "Expected element on list ${Locator} with value '${value}' to not be selected but was"
                END
            END
        END

        IF   '${element_found}' == 'false'
            Fail     "Expected element on list ${Locator} with value '${value}' to not be selected, but element was not found"
        END
    END