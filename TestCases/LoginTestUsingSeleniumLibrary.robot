*** Settings ***
Library           SeleniumLibrary
Library           CustomLib.py
Library           Ec2UsageCalculator.py    65.2.29.173

*** variables ***
${url}  https://www.saucedemo.com/
${browser}  chrome
${password}  secret_sauce
${getmemoryUtlizationCmd}    free | grep Mem | awk '{print ($2-$7)/$2 * 100}'
${getCpuUtlizationCmd}    top -b -n 1 -d1 | grep "%Cpu(s)"


*** Test Cases ***
loginTestinvalid
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

getprintTest
    [tags]    opss
    print word


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





