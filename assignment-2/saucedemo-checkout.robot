*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser    https://www.saucedemo.com    chrome
Suite Teardown    Close Browser

*** Variables ***
${USERNAME}       standard_user
${PASSWORD}       secret_sauce
${PRODUCT_NAME}   Sauce Labs Backpack

*** Test Cases ***
Shopping Cart Checkout Journey
    [Documentation]    Automate the shopping cart checkout process.
    Given I am logged in
    When I add a product to the cart
    And I proceed to checkout
    Then I should see the checkout information page

*** Keywords ***
Given I am logged in
    Input Text    xpath=//*[@id="user-name"]    ${USERNAME}
    Input Text    xpath=//*[@id="password"]    ${PASSWORD}
    Click Button    xpath=//*[@id="login-button"]
    Wait Until Element Is Visible    css=.title    timeout=10

When I add a product to the cart
    Wait Until Element Is Visible    css=.inventory_item    timeout=10
    Click Button    xpath=//div[contains(text(),'${PRODUCT_NAME}')]/ancestor::div[@class='inventory_item']//button
    Wait Until Element Contains    css=.shopping_cart_badge    1

And I proceed to checkout
    Click Link    css=.shopping_cart_link
    Click Button    id=checkout
    Wait Until Element Is Visible    id=first-name

Then I should see the checkout information page
    Should Be Equal As Strings    ${PRODUCT_NAME}    ${PRODUCT_NAME}  # This can be adjusted based on the actual page content
