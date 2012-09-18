@javascript
Feature: Manage Clients
  In order to manage clients
  As an User
  I want to create and manage clients

  Background: 
    Given I have the following clients:
      |name                 |rut      |contact  |address                |email                |phone    | supplier_id |
      |VAIRIX               |19089098 |Alvaro   |25 de mayo 555 of 409  |contacto@vairix.com  |29103024 | 1           |
      |XSeed                |19198980 |Marcelo  |Av. Italia 1223 of 191 |info@xseed.com       |27101200 | 1           |
      |Clinica Muhlethaler  |12322342 |Daniela  |Ellauri 891            |contacto@clinica.com |27110330 | 1           |
    And I am a new, authenticated user


  Scenario: Client list
    When I am on the clients page
    Then I should see "VAIRIX, XSeed" clients

  Scenario: New Client
    When I am on the new client page
    And I fill in the following:
      | Name     | Coca-Cola           |
      | Rut      | 19098989            |
      | Contact  | Carlos Gutierrez    |
      | Email    | carlitos@gmail.com  |
      | Address  | Colonia 2232 ap 109 |
      | Phone    | 29089898            |

    And I press "Save" 
    Then I am on the clients page
    And I should see "Coca-Cola" client

  Scenario: Edit Client
    When I am on the clients page
    And I follow the "Edit" link for "VAIRIX"
    And I fill in "Rut" with "19000000"
    And I press "Save"
    Then I visit "VAIRIX" client details
    And I should see "19000000"

  Scenario: Delete Client
    When I am on the clients page
    And I follow the "Destroy" link for "XSeed"
    And I confirm popup
    Then I am on the clients page
    And I should not see "XSeed"

  Scenario: Show Client
    When I am on the clients page
    And I follow the "Show" link for "VAIRIX"
    Then I should see "19089098"
    And I should see "VAIRIX"
    And I should see "Alvaro"
