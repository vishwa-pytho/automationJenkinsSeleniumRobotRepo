*** Settings ***
Library           SeleniumLibrary

*** variables ***
${url}  https://www.saucedemo.com/
${browser}  chrome
${username}  standard_user
${password}  secret_sauce

*** Test Cases ***
LoginTestinvalid
    [TAGS]    ui
    create webdriver    chrome    executable_path="/usr/bin/google-chrome"
    open browser    ${url}    ${browser}
    enterUserNameAndPassword
    click element  id:login-button
    Element Text Should Be    class:title    PRODUCTS
    close browser

*** keywords ***
enterUserNameAndPassword
    input text  id:user-name   ${username}
    input text  id:password    ${password}





