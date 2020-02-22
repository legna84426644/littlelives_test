*** Settings ***
Resource    ${EXEC_DIR}/Common/resource.robot
Resource    ${EXEC_DIR}/Common/common_selectors.robot

*** Keywords ***
Login And Go To Attendance Page
    Start Browser
    Login    ${USER}    ${PWD}
    Wait For Main Page Loaded
    Click Element    css=a[href="/attendances"]
    Wait Until Page Contains Element    xpath=//div[contains(@data,"[object Object]")]

