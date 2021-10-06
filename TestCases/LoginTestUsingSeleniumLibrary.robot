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
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    headless
    Call Method    ${options}    add_argument    disable-gpu
    create webdriver    Chrome    headlessChrome    executable_path=/usr/bin/chromedriver    chrome_options=${options}
    go to    ${url}
    enterUserNameAndPassword
    click element  id:login-button
    Element Text Should Be    class:title    PRODUCTS
    close browser

*** keywords ***
enterUserNameAndPassword
    ${username}    get random name
    input text  id:user-name   ${username}
    input text  id:password    ${password}





