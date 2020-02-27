*** Settings ***
Library    SeleniumLibrary    timeout=5.0    run_on_failure=Capture Page Screenshot
Library    DateTime
Resource    ${EXEC_DIR}/Common/common_keywords.robot
Resource    ${EXEC_DIR}/Common/common_selectors.robot

*** Variables ***
${URL}    https://staging.littlelives.com
${BROWSER}    chrome
${USER}    dotdad@littlelives.com
${PWD}    123456

*** Keywords ***
Start Browser
    ${list} =     Create List    --no-sandbox    --disable-dev-shm-usage
    ${args} =     Create Dictionary    args=${list}
    ${desired caps} =     Create Dictionary     chromeOptions=${args}
    Open Browser    ${URL}    ${BROWSER}    desired_capabilities=${desired caps}
    Maximize Browser Window

Login
    [Arguments]    ${user}    ${pwd}
    Input Text    css=input#UserUsername    ${user}
    Input Text    css=input#UserPassword    ${pwd}
    Click Element    css=input[value="Sign In"]

Wait For Main Page Loaded
    Wait Until Page Contains Element    css=header#ll-header
    Run Keyword And Ignore Error    Click Element    css=button#btn-close-modal-video-player
