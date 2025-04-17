*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://staging-sally.kbfinansia.com/auth/login
${BROWSER}        Chrome
${CHROME_OPTIONS}    add_argument("--start-fullscreen"); 

*** Test Cases ***
gherkin-test
    Given open login page
    When input username and password
    And click button Login
    Then login success
    Then logout

*** Keywords ***
open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    
input username and password
    Input Text    xpath://input[@id='username']    dhandyjoenathan
    Input Text    xpath://input[@id='password']    201017Dj*#*#

click button Login
    Click Element    xpath://button[normalize-space()='LOGIN']

login success
    Wait Until Element Is Visible    xpath://h3[normalize-space()='Profile']
    Element Should Be Visible    xpath://h3[normalize-space()='Profile']
    Element Text Should Be    xpath://h3[normalize-space()='Profile']    Profile

logout
    Click Element    xpath://div[@class='kt-header__topbar-wrapper']//img[@alt='Pic']
    Click Element    xpath://button[normalize-space()='Logout']
    Click Element    xpath://button[normalize-space()='Yes!']
    Element Should Be Visible    xpath://h3[normalize-space()='LOGIN']
    Element Text Should Be    xpath://h3[normalize-space()='LOGIN']    LOGIN
    Close Browser
