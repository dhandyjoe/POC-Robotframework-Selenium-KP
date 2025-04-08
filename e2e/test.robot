*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Resource    keyword.robot

*** Variables ***
# ${LOGIN URL}      https://staging-sally.kbfinansia.com/auth/login
# ${BROWSER}        Chrome
# ${CHROME_OPTIONS}    add_argument("--start-fullscreen"); 
# add_argument("--headless")

*** Test Cases ***
asd
    loginSallyWeb
    logoutSallyWeb
