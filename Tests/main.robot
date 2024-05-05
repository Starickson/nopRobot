*** Settings ***
Library     SeleniumLibrary
Documentation    Cet exemple d'automatisation des tests me permet de m'exercer sur RBF   
...              Elle osciclle entre le site demo-nopcommerce et cdiscount 
Resource    ../Resources/resource.robot
Suite Teardown    Run Keyword    Delete All Cookies


*** Test Cases ***

Start
    Start_webdriver    ${nop_url}    chrome

Login
    Login_account

SignIn
    EnterEmailPasswordLogin    ${email}    ${password}
    Click Button    //button[@type='submit' and contains(.,'Log in')]

User_isPresent
    # ${variable} =    Run Keyword And Return Status    Element Should Be Visible    //div[@class='message-error validation-summary-errors']
    # Run Keyword If    '${variable}' =='TRUE'    
    # ...    Close browser     
    # ELSE    Click Button     //button[@type='button' and contains(.,'Register')] 

    ${variable} =    Run Keyword And Return Status    Element Should Be Visible    //div[@class='message-error validation-summary-errors']
    Run Keyword If    '${variable}' == 'True'    
    ...    Create account    ${user}[gender]     ${user}[firstName]      ${user}[lastName]       ${user}[dayOfBirth]       ${user}[monthOfBirth]       ${user}[yearOfBith]       ${user}[email]       ${user}[password]  
    ...    ELSE     
    ...    Element Should Be Visible    //a[@href='/logout'] 
       
# Click Link    //div[@class='header-logo']/a 

# validation de la monnaie
Currency 
    SelectCurrency    ${euro_currency}

# Selection d'une catégorie au hasard 
Select_random_cat
    ${var}=    Get Random Number    
    Log    Random Number: ${var}
    Select_category_by_random    ${var}
        
    


 


        


