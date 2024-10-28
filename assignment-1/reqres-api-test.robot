*** Settings ***
Library           RequestsLibrary

*** Variables ***
${BASE_URL}      https://reqres.in/api

*** Test Cases ***
Get Single User
    [Documentation]    Verify the retrieval of a single user by ID.
    Given the user ID is 2
    When I send a GET request to the single user endpoint
    Then the response status code should be 200
    And the response body should contain the user information

Create User
    [Documentation]    Verify the creation of a new user.
    Given I have user details for creation
    When I send a POST request to create a user
    Then the response status code should be 201
    And the response body should contain the created user information

*** Keywords ***
Given the user ID is 2
    Set Suite Variable    ${user_id}    2

When I send a GET request to the single user endpoint
    ${response}=    GET    ${BASE_URL}/users/${user_id}
    Set Suite Variable    ${response_code}    ${response.status_code}
    Set Suite Variable    ${response_body}    ${response.json()}

Then the response status code should be 200
    Should Be Equal As Numbers    ${response_code}    200

And the response body should contain the user information
    Should Not Be Empty    ${response_body}[user]
    Should Be Equal As Strings    ${response_body}[user][id]    ${user_id}

Given I have user details for creation
    Set Suite Variable    ${new_user_payload}    {"name": "John", "job": "Developer"}

When I send a POST request to create a user
    ${response}=    POST    ${BASE_URL}/users    json=${new_user_payload}
    Set Suite Variable    ${response_code}    ${response.status_code}
    Set Suite Variable    ${response_body}    ${response.json()}

Then the response status code should be 201
    Should Be Equal As Numbers    ${response_code}    201

And the response body should contain the created user information
    Should Not Be Empty    ${response_body}[name]
    Should Not Be Empty    ${response_body}[job]
    Should Not Be Empty    ${response_body}[id]
