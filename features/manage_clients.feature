@javascript
Feature: Manage Clients
  In order to manage clients
  As an User
  I want to create and manage clients

  Background: 
    Given I have the following clients:
      |name                 |rut      |contact  |address                |email                |phone    |
      |VAIRIX               |19089098 |Alvaro   |25 de mayo 555 of 409  |contacto@vairix.com  |29103024 |
      |XSeed                |19198980 |Marcelo  |Av. Italia 1223 of 191 |info@xseed.com       |27101200 |
      |Clinica Muhlethaler  |12322342 |Daniela  |Ellauri 891            |contacto@clinica.com |27110330 |
    And I am a new, authenticated user


  Scenario: Client list
    When I am on the clients page
    Then I should see "VAIRIX, XSeed" clients

    #  Scenario: New Client 
    #When I am on the new client page
    #And I fill in 
    #Then I should see "VAIRIX, XSeed" clients
