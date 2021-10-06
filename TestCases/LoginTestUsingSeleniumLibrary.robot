*** Settings ***
Library           SeleniumLibrary
Library           CustomLib.py

*** variables ***
${url}  https://www.saucedemo.com/
${browser}  chrome
${password}  secret_sauce


*** Test Cases ***
LoginTestinvalid
    [TAGS]    ui
    create webdriver    chrome    executable_path="/usr/bin/chromedriver"
    open browser    ${url}    ${browser}
    enterUserNameAndPassword
    click element  id:login-button
    Element Text Should Be    class:title    PRODUCTS
    close browser

*** keywords ***
enterUserNameAndPassword
    ${username}    get random name
    input text  id:user-name   ${username}
    input text  id:password    ${password}





