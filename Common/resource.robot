*** Settings ***
Library    SeleniumLibrary    timeout=5.0    run_on_failure=Capture Page Screenshot
Library    DateTime
Library     XvfbRobot
Resource    ${EXEC_DIR}/Common/common_keywords.robot
Resource    ${EXEC_DIR}/Common/common_selectors.robot

*** Variables ***
${URL}    https://staging.littlelives.com
${BROWSER}    chrome
${USER}    dotdad@littlelives.com
${PWD}    123456
${TMP_PATH}    /tmp

*** Keywords ***
Start Browser
    Start Virtual Display    1920    1080
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method  ${options}  add_argument  --no-sandbox
    ${prefs}    Create Dictionary    download.default_directory=${TMP_PATH}
    Call Method    ${options}    add_experimental_option    prefs    ${prefs}
    Create Webdriver    Chrome    chrome_options=${options}
    GoTo    ${URL}

Login
    [Arguments]    ${user}    ${pwd}
    Input Text    css=input#UserUsername    ${user}
    Input Text    css=input#UserPassword    ${pwd}
    Click Element    css=input[value="Sign In"]

Wait For Main Page Loaded
    Wait Until Page Contains Element    css=header#ll-header
    Run Keyword And Ignore Error    Click Element    css=button#btn-close-modal-video-player
