*** Settings ***
Library           SeleniumLibrary

Library           CustomLib.py
variables         ../config/variables.py
Library           Ec2UsageCalculator.py    ${hostname}    

*** variables ***
${url}  https://www.saucedemo.com/
${browser}  chrome
${password}  secret_sauce

*** Test Cases ***
loginTestValidCredentials
    [TAGS]    ui
    openHeadlessModeChrome
    go to    ${url}
    enterUserNameAndPassword
    click element  id:login-button
    Element Text Should Be    class:title    PRODUCTS
    close browser

getMemUtlizationTest
    [Tags]    cli
    ${memoryUtl}    get memory utlization    ${getmemoryUtlizationCmd}
    log    ${memoryUtl}
    should be true    (${memoryUtl}<80)
    write output to file with timestamp    ${memoryUtl}    "Memory utlization"

getCpuUtlizationTest
    [Tags]    cli
    ${cpuUtl}    get cpu utlization    ${getCpuUtlizationCmd}
    should be true    (${cpuUtl}<80)
    write output to file with timestamp    ${cpuUtl}    "Cpu utlization"

diskSpaceTest
    [tags]    cli
    ${diskspace}    disk space calculator
    write output to file with timestamp    \n${diskspace}    "disk space"

*** keywords ***
enterUserNameAndPassword
    ${username}    get random name
    input text  id:user-name   ${username}
    input text  id:password    ${password}

openHeadlessModeChrome
    ${options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${options}    add_argument    disable-dev-shm-usage
    Call Method    ${options}    add_argument    no-sandbox
    Call Method    ${options}    add_argument    headless
    Call Method    ${options}    add_argument    disable-gpu
    create webdriver    Chrome    headlessChrome    executable_path=/usr/bin/chromedriver    chrome_options=${options}





