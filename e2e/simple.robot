*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://staging-sally.kbfinansia.com/auth/login
${BROWSER}        Chrome
${CHROME_OPTIONS}    add_argument("--start-fullscreen"); add_argument("--headless")

*** Test Cases ***
test valid login
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Input Text    xpath://input[@id='username']    dhandyjoenathan
    Input Text    xpath://input[@id='password']    201017Dj*#*#
    Click Element    xpath://button[normalize-space()='LOGIN']
    Wait Until Element Is Visible    xpath://h3[normalize-space()='Profile']
    Element Should Be Visible    xpath://h3[normalize-space()='Profile']
    Element Text Should Be    xpath://h3[normalize-space()='Profile']    Profile
    logoutSallyWeb

test invalid login
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Input Text    xpath://input[@id='username']    qweqwe
    Input Text    xpath://input[@id='password']    qweqwe
    Click Element    xpath://button[normalize-space()='LOGIN']
    Wait Until Element Is Visible    xpath://div[@class='alert-text']
    Element Should Be Visible    xpath://div[@class='alert-text']
    Element Text Should Be    xpath://div[@class='alert-text']    Mohon masukan Password yang sesuai (Minimal 8 karakter)
    Close Browser

test null username password
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Click Element    xpath://button[normalize-space()='LOGIN']
    Sleep    0.5s
    Element Should Be Visible    xpath://div[normalize-space()='Password tidak boleh kosong']
    Element Should Be Visible    xpath://div[normalize-space()='Username tidak boleh kosong']
    Element Text Should Be    xpath://div[normalize-space()='Password tidak boleh kosong']    Password tidak boleh kosong
    Element Text Should Be    xpath://div[normalize-space()='Username tidak boleh kosong']    Username tidak boleh kosong
    Close Browser

*** Keywords ***
logoutSallyWeb
    Click Element    xpath://div[@class='kt-header__topbar-wrapper']//img[@alt='Pic']
    Click Element    xpath://button[normalize-space()='Logout']
    Click Element    xpath://button[normalize-space()='Yes!']
    Element Should Be Visible    xpath://h3[normalize-space()='LOGIN']
    Element Text Should Be    xpath://h3[normalize-space()='LOGIN']    LOGIN
    Close Browser
