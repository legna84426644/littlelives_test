*** Settings ***
Documentation    Test Attendance View
Suite Setup    Login And Go To Attendance Page
#Test Teardown    Close Browser
Resource    ${EXEC_DIR}/Common/resource.robot
Resource    ${EXEC_DIR}/Common/common_keywords.robot
Resource    ${EXEC_DIR}/Common/common_selectors.robot

Force Tags    attendance

*** Test Cases ***
Declare Day Off
    [Documentation]    Declare Day Off for yesterday, today, and tomorrow
    ${start_day}    Get Current Date    time_zone=UTC   increment=-1 days    result_format=%Y-%m-%d
    ${end_day}    Get Current Date    time_zone=UTC   increment=1 days    result_format=%Y-%m-%d
    ${reason}    Set Variable    This is a test reason
    ${today}    Get Current Date    time_zone=UTC    result_format=%Y-%m-%d
    Select Attendance Date    ${today}
    Declare Day Off    ${start_day}    ${end_day}    ${reason}
    Declare Day Off Successfully

Cancel Day Off
    [Documentation]    Cancel Day Off For Today
    ${today}    Get Current Date    time_zone=UTC    result_format=%Y-%m-%d
    Cancel Day Off    ${today}

Print Parent Check In QR Code
    [Documentation]    Print QR Code For yesterday, today, and tomorrow
    ${start_day}    Get Current Date    time_zone=UTC   increment=-1 days    result_format=%Y-%m-%d
    ${end_day}    Get Current Date    time_zone=UTC   increment=1 days    result_format=%Y-%m-%d
    Print QR Code    ${start_day}    ${end_day}

Select Date
    [Documentation]    Select Date For yesterday, today, and tomorrow
    ${yesterday}    Get Current Date    time_zone=UTC   increment=-1 days    result_format=%Y-%m-%d
    ${future}    Get Current Date    time_zone=UTC   increment=1 days    result_format=%Y-%m-%d
    ${today}    Get Current Date    time_zone=UTC    result_format=%Y-%m-%d
    Select Attendance Date    ${today}
    Select Attendance Date    ${yesterday}
    Select Attendance Date    ${future}

*** Keywords ***
Confirm Dialog
    Wait Until Page Contains Element    xpath=//div[contains(@class,"v-dialog--active")][not(contains(@class,"dialog-transition-enter-active"))]
    Click Element    xpath=//div[contains(@class,"v-dialog--active")]//div[text()="Apply"]
    Wait Until Page Does Not Contain Element    css=div.v-dialog--active

Declare Day Off
    [Arguments]    ${start_day}    ${end_day}    ${reason}
    Mouse Over    css=img[alt="More option"]
    Wait Until Element Is Visible    css=ul.attendance-more-context__menu-list
    Click Element    xpath=//li[text()="Declare day off"]
    Wait Until Element Is Visible    css=div.popup-attendance-declare-day-off.v-dialog--active
    Input Text    css=textarea[aria-label="Reason"]     ${reason}
    Execute JavaScript    document.querySelector("div.v-dialog--active input[aria-label='Start Date']").value='${start_day}'
    Execute JavaScript    document.querySelector("div.v-dialog--active input[aria-label='End Date']").value='${end_day}'
    Click Element    xpath=//div[contains(@class,"v-dialog--active")]//div[text()="Apply"]
    Wait Until Element Is Not Visible    css=div.popup-attendance-declare-day-off.v-dialog--active

Declare Day Off Successfully
    Wait Until Page Contains Element    xpath=//div[contains(text(),"Declare day off for this school successfully")]
    Wait Until Element Is Visible    xpath=//span[contains(text(),"Cancel day off for")]

Select Attendance Date
    [Arguments]    ${date}
    Execute JavaScript    document.querySelector("input.filter-date__input-date-picker").value='${date}'
    Wait Until Page Contains Element    xpath=//div[contains(@data,"[object Object]")]

Cancel Day Off
    [Arguments]    ${date}
    Select Attendance Date    ${date}
    Click Element    xpath=//span[contains(text(),"Cancel day off for")]
    Confirm Dialog
    Wait Until Page Contains Element    xpath=//div[contains(text(),"Cancel holiday for this school successfully")]
    Wait Until Element Is Not Visible    xpath=//span[contains(text(),"Cancel day off for")]

Print QR Code
    [Arguments]    ${start_day}    ${end_day}
    Mouse Over    css=img[alt="More option"]
    Wait Until Element Is Visible    css=ul.attendance-more-context__menu-list
    Click Element    xpath=//li[text()="Print Parent Check In QR Code"]
    Wait Until Element Is Visible    css=div.popup-attendance-print-checkin-qr-code.v-dialog--active
    Execute JavaScript    document.querySelector("div.v-dialog--active input[aria-label='Start Date']").value='${start_day}'
    Execute JavaScript    document.querySelector("div.v-dialog--active input[aria-label='End Date']").value='${end_day}'
    Click Element    xpath=//div[contains(@class,"v-dialog--active")]//div[text()="Generate"]
    Wait Until Page Contains Element    css=span.v-btn__loading
    Wait Until Page Does Not Contain Element    css=span.v-btn__loading
    Click Element    css=div.v-image div.v-responsive__content
    ${handle}    Select Window    NEW
    Sleep    2s
    # todo: get current url and compare
    Close Window
    Select Window    MAIN
    Click Element    xpath=//div[contains(@class,"v-dialog--active")]//div[text()="Cancel"]