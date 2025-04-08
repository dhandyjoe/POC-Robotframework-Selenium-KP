*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${LOGIN URL}      https://staging-sally.kbfinansia.com/auth/login
${BROWSER}        Chrome
${CHROME_OPTIONS}    add_argument("--start-fullscreen"); 
# add_argument("--headless")

*** Test Cases ***
Manajemen Prospek: data not found 
    loginSallyWeb

    Click Element    xpath://span[normalize-space()='Kunjungan Dealer']
    Click Element    xpath://span[normalize-space()='Manajemen Prospek']    
    Element Should Be Visible    xpath://div[@class='kt-portlet__head-label']
    Element Text Should Be    xpath://div[@class='kt-portlet__head-label']    Manajemen Prospek

    Click Element    xpath://input[@id='period']
    Click Element    xpath://button[normalize-space()='Apply']
    Click Element    xpath://button[@id='filter']
    Sleep    2s

    Element Should Be Visible    xpath://td[@class='dt-empty']
    Element Text Should Be    xpath://td[@class='dt-empty']    No data available in table

    logoutSallyWeb

Manajemen Prospek: valid data
    loginSallyWeb

    Click Element    xpath://span[normalize-space()='Kunjungan Dealer']
    Click Element    xpath://span[normalize-space()='Manajemen Prospek']    
    Element Should Be Visible    xpath://div[@class='kt-portlet__head-label']
    Element Text Should Be    xpath://div[@class='kt-portlet__head-label']    Manajemen Prospek

    Click Element    xpath://input[@id='period']
    checkMonthName
    Click Element    xpath://button[@id='filter']
    Sleep    3s
    Element Should Be Visible    xpath://*[@id="table-data-table"]/tbody/tr[1]

    Element Should Be Visible    xpath://*[@id="table-data-table_wrapper"]/div[3]/div[3]
    Click Element    xpath://tbody/tr[1]/td[7]/div[1]/a[1]

    # Detail - Data Dealer
    Element Should Be Visible    xpath://h3[normalize-space()='Data Dealer']
    Element Text Should Be    xpath://h3[normalize-space()='Data Dealer']    Data Dealer
    Element Text Should Be    //b[normalize-space()='Data Kunjungan']    Data Kunjungan
    Element Text Should Be    //b[normalize-space()='Data Dealer']    Data Dealer
    Element Text Should Be    //b[normalize-space()='Data Prospek']    Data Prospek

    Element Text Should Be    //label[normalize-space()='VISIT FINISHED']    VISIT FINISHED
    Element Text Should Be    //label[normalize-space()='DEALER PROSPEK']    DEALER PROSPEK

    # Detail - Data Stock Financing
    Click Element    xpath://button[normalize-space()='Data Stock Financing']
    Sleep     0.5s
    Element Should Be Visible    xpath://h3[normalize-space()='Data Stock Financing']

    Element Should Be Visible    xpath://label[normalize-space()='Jumlah Stock Unit Saat Kunjungan']
    Element Should Be Visible    xpath://label[normalize-space()='Restock Bulan Ini']
    Element Should Be Visible    xpath://label[normalize-space()='Stock Unit Terjual Bulan Ini']
    Element Should Be Visible    xpath://label[normalize-space()='Memiliki Pembiayaan Dari Multi Finance Lain']
    
    Element Text Should Be    xpath://label[normalize-space()='100']    100
    Element Text Should Be    xpath://label[normalize-space()='12']    12

    # Detail - Dokumen Pendukung
    Click Element    xpath://button[normalize-space()='Dokumen Pendukung']
    Sleep    0.5s
    Element Should Be Visible    xpath://h3[normalize-space()='Data Dokumen Pendukung']
    Element Should Be Visible    xpath://b[normalize-space()='Foto Kunjungan']
    Element Should Be Visible    xpath://b[normalize-space()='Foto Tambahan']

    Click Element    xpath://div//div//div//div//div//div//div//div//div[1]//div[2]//div[1]//div[1]//img[1]
    Sleep    1s
    Element Should Be Visible    xpath://*[@id="modalImageAddress"]/div/div
    Click Element    xpath://*[@id="modalImageAddress"]/div/div/div[1]/button

    Click Element    xpath://div[@id='data-document']//a[contains(@class,'btn btn-secondary px-5 mr-2')][normalize-space()='Kembali']
    Element Text Should Be    xpath://div[@class='kt-portlet__head-label']    Manajemen Prospek

    logoutSallyWeb


Master Kunjungan Dealer: detail, create
    loginSallyWeb

    Click Element    xpath://span[normalize-space()='Kunjungan Dealer']
    Click Element    xpath://span[normalize-space()='Master Kunjungan Dealer']
    Element Should Be Visible    xpath://h3[@class='kt-portlet__head-title']
    Element Text Should Be    xpath://h3[@class='kt-portlet__head-title']    Master Kunjungan Dealer

    # Create
    Input Text    xpath://input[@id='dt-search-0']    MO
    Sleep    0.5s
    Click Element    xpath://*[@id="table-data-table"]/tbody/tr[1]/td[2]/div/a[2]

    Element Should Be Visible    xpath://h3[normalize-space()='Penalti']
    Element Should Be Visible    xpath://h3[normalize-space()='Target Aktivitas Kunjungan / Bulan']
    
    Clear Element Text    xpath://input[@id='input-1']
    Input Text    xpath://input[@id='input-1']    10

    Clear Element Text    xpath://input[@id='input-2']
    Input Text    xpath://input[@id='input-2']    10

    Clear Element Text    xpath://input[@id='input-3']
    Input Text    xpath://input[@id='input-3']    10

    Input Text    xpath://input[@id='input-allBranch']    20

    Click Element    xpath://button[@id='btn-simpan']
    Click Element    xpath://button[contains(@type,'button')][normalize-space()='Simpan']
    Sleep    1s
    Click Element    xpath://button[normalize-space()='Mengerti']
    Element Text Should Be    xpath://h3[@class='kt-portlet__head-title']    Master Kunjungan Dealer

    # Detail
    Input Text    xpath://input[@id='dt-search-0']    MO
    Sleep    0.5s
    Click Element    xpath://a[@href='master-kunjungan-dealer/MO/detail']

    Element Should Be Visible    xpath://h6[normalize-space()='Penalti']
    Element Should Be Visible    xpath://h6[normalize-space()='Target Aktivitas Kunjungan / Bulan']

    Element Text Should Be    xpath://body[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[1]/td[2]    10%
    Element Text Should Be    xpath://body[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[2]/td[2]    10%
    Element Text Should Be    xpath://body[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[1]/div[1]/table[1]/tbody[1]/tr[3]/td[2]    10%
    Element Text Should Be    xpath://body[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[2]/div[1]/table[1]/tbody[1]/tr[1]/td[3]    20

    Click Element    xpath://a[normalize-space()='Kembali']
    Element Text Should Be    xpath://h3[@class='kt-portlet__head-title']    Master Kunjungan Dealer

    logoutSallyWeb

Manajemen Kunjungan Dealer: Create Penugasan
    loginSallyWeb

    Click Element    xpath://span[normalize-space()='Kunjungan Dealer']
    Click Element    xpath://span[normalize-space()='Manajemen Kunjungan Dealer']
    Element Should Be Visible    xpath://h3[normalize-space()='Kunjungan Dealer']
    Element Text Should Be    xpath://h3[normalize-space()='Kunjungan Dealer']    Kunjungan Dealer

    # Create 
    Click Element    xpath://a[normalize-space()='Tambah Penugasan']
    Click Element    xpath://span[@id='select2-dealer_name-container']
    Input Text    xpath://input[@role='searchbox']    118 MOBILINDO
    Sleep    2s
    Click Element    xpath://*[@id="select2-dealer_name-results"]/li[1]
    Sleep    2s

    Click Element    xpath://span[@id='select2-pic-container']
    Input Text    xpath://input[@role='searchbox']    ABDUL MUIS
    Sleep    2s
    Click Element    xpath://*[@id="select2-pic-results"]/li[1]

    Click Element    xpath://input[@id='task_date']
    Click Element    xpath://button[normalize-space()='Apply']

    Input Text    xpath://input[@id='visit_count']    5

    Click Element    xpath://button[@id='btn-submit']
    Element Text Should Be    xpath://div[@id='swal2-content']    Kunjungan ke dealer 118 MOBILINDO akan ditugaskan kepada ABDUL MUIS dengan 5 kelipatan kunjungan

    Click Element    xpath://button[normalize-space()='Tugaskan']
    Sleep    1s
    Click Element    xpath://button[normalize-space()='Mengerti']
    Element Text Should Be    xpath://h3[normalize-space()='Kunjungan Dealer']    Kunjungan Dealer
    Sleep    1s

    # Detail
    Element Text Should Be    xpath://tbody/tr[1]/td[2]    118 MOBILINDO
    Element Text Should Be    xpath://tbody/tr[1]/td[4]    ABDUL MUIS
    Click Element    xpath://body[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[2]/div[3]/div[3]/div[3]/table[1]/tbody[1]/tr[1]/td[8]/div[1]/a[1]/i[1]

    Element Should Be Visible    xpath://h3[normalize-space()='Data Dealer']
    Element Should Be Visible    xpath://b[normalize-space()='Data Kunjungan']
    Element Should Be Visible    xpath://b[normalize-space()='Data Dealer']
    Element Should Be Visible    xpath://label[normalize-space()='118 MOBILINDO']    

    Click Element    xpath://div[@id='data-dealer']//a[contains(@class,'btn btn-secondary px-5 mr-2')][normalize-space()='Kembali']
    Element Text Should Be    xpath://h3[normalize-space()='Kunjungan Dealer']    Kunjungan Dealer

    logoutSallyWeb

*** Keywords ***                                          
loginSallyWeb
    Open Browser    ${LOGIN URL}    ${BROWSER}    options=${CHROME_OPTIONS}
    Input Text    xpath://input[@id='username']    dhandyjoenathan
    Input Text    xpath://input[@id='password']    201017Dj*#*#
    Click Element    xpath://button[normalize-space()='LOGIN']
    Wait Until Element Is Visible    xpath://h3[normalize-space()='Profile']
    Element Should Be Visible    xpath://h3[normalize-space()='Profile']
    Element Text Should Be    xpath://h3[normalize-space()='Profile']    Profile

logoutSallyWeb
    Click Element    xpath://div[@class='kt-header__topbar-wrapper']//img[@alt='Pic']
    Click Element    xpath://button[normalize-space()='Logout']
    Click Element    xpath://button[normalize-space()='Yes!']
    Element Should Be Visible    xpath://h3[normalize-space()='LOGIN']
    Element Text Should Be    xpath://h3[normalize-space()='LOGIN']    LOGIN
    Close Browser

checkMonthName
    ${bulan_text}=    Get Text    xpath=/html/body/div[6]/div[2]/div[1]/table/thead/tr[1]/th[2]
    Run Keyword If    '${bulan_text}' == 'Feb 2025'
    ...    Run Keywords
    ...    Click Element    xpath=/html/body/div[6]/div[2]/div[1]/table/tbody/tr[1]/td[7]
    ...    AND    Click Element    xpath=/html/body/div[6]/div[2]/div[1]/table/tbody/tr[5]/td[6]
    ...    AND    Click Element    xpath=//button[normalize-space()='Apply']

    Run Keyword If    '${bulan_text}' != 'Feb 2025'
    ...    Run Keywords
    ...    Click Element    xpath=//th[@class='prev available']
    ...    AND    Check Month Name

        