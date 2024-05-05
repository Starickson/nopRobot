*** Settings ***
Library    SeleniumLibrary
Library    ../Data/chromedriversync.py
Library    ../Data/utilitaires.py


*** Variables ***
${gender}     male
${firstName}      franck
${lastName}         DUPONT    
${dayOfBirth}      2
${monthOfBirth}     2
${yearOfBith}     2000
${email}     palerie@yopmail.fr
${password}     123456789
${chrome}     chrome
${nop_url}    https://demo.nopcommerce.com/
${firefox}    firefox
${cdiscount}    https://www.cdiscount.com/
&{user}       gender=${gender}    firstName=${firstName}    lastName=${lastName}    dayOfBirth=${dayOfBirth}    
...    monthOfBirth=${monthOfBirth}    yearOfBith=${yearOfBith}    email=${email}    password=${password}
${euro_currency}    Euro
${dollars_currency}    US Dollar
@{categories}    Computers     Electronics    Apparel    Digital    downloads    Books    Jewelry    Gift Cards 



*** Keywords ***


Start_webdriver
    [Arguments]    ${url}    ${browser}
    ${driver_path}=    chromedriversync.Get Driver Path With Browser        ${browser}
    Open Browser          ${url}         ${browser}      executable_path=${driver_path} 
    # Go to    ${url}
    Maximize Browser Window
    

Login_account
    Wait Until Element Is Visible     //a[@href="/login?returnUrl=%2F" and contains(.,'Log in')]
    Click Link    //a[@href="/login?returnUrl=%2F" and contains(.,'Log in')]
    Sleep    2

EnterEmailPasswordLogin
    [Arguments]  ${email}    ${password}
    Input Text    Email    ${email}
    Input Text    Password    ${password}
    Sleep    2


register_button_access
    Click Button    //button[@type='button' and contains(.,'Register')]


 Create account
     [Arguments]      ${gender}     ${firstName}      ${lastName}     ${dayOfBirth}     ${monthOfBirth}     ${yearOfBith}     ${email}     ${password}
    #  il faut avant tout acceder au formulaire de création de compte 
     register_button_access

    #  Traitement Formulaire  
     IF  '$gender == male'
         Click Button    gender-male 
     END
     IF  '$gender == female'
         Click Button    gender-female 
     END
     Input Text    FirstName    ${firstName}
     Input Text    LastName     ${lastName}
     Select From List By Value   name=DateOfBirthDay    ${dayOfBirth}
     Select From List By Value   name=DateOfBirthMonth    ${monthOfBirth}
     Select From List By Value   name=DateOfBirthYear    ${yearOfBith}
     Input Text    Email    ${email}
     Input Password    Password    ${password}
     Input Password    ConfirmPassword    ${password}

     register_form_validation



register_form_validation
    Click Button    register-button
    Wait Until Element Is Visible    //h1[text()='Register']
    Element Text Should Be    //h1[text()='Register']    Register

     
    # Click Button    //button[@type='submit' and contains(.,'Log in')]
    # Sleep    5
Close the Browser
    Close All Browsers

Check if 
    Click Link    //
Check account 
    Element Should Be Visible    //div[@class='message-error validation-summary-errors']
    Element Text Should Be  //div[@class='message-error validation-summary-errors']    Login was unsuccessful. Please correct the errors and try again.


SelectCurrency
    # Selection d'une monnaie 
    [Arguments]    ${currency}
    Select From List By Label    customerCurrency    ${currency}
    # et verification que choix est validé dans un select 
    Page Should Contain    Euro
    ${var}    Get Selected List Label    customerCurrency
    Log    ${var}


Select_category_by_random
    [Arguments]    ${var}
    Wait Until Element Is Visible    //div[@class="header-menu"]//ul[@class="top-menu notmobile"]/li[${var}]/a
    Click Link    //div[@class="header-menu"]//ul[@class="top-menu notmobile"]/li[${var}]/a
    Sleep    3




