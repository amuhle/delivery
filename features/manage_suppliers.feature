@javascript
Feature: Manage Supplier
  In order to manage suppliers
  As an User
  I want to create and manage suppliers

  Background:
    Given I have the following suppliers:
      |name                 |phone       |email              |adddress            |rut        |contact_person |
      |Aromas del campo     |27989899    |aromas@gmail.com   |Av. Chacabuco 1212  |1908989898 |Natalia        |
      |Quiosko Pepe         |29089098    |pepito@hotmail.com |Av. Italia 1212     |1008912121 |Pepe           |  
      |Panaderia Santoral   |29091212    |santo@gmail.com    |Ituzaingo 546       |1237878787 |Carlos         |
    And I am a new, authenticated user

  Scenario: Suppliers list
    When I am on the suppliers page
    Then I should see "Aromas, Pepe, Santoral" suppliers

  Scenario: New Suppliers
    When I am on the new supplier page
    And I fill in the following:
      | Name          | VAIRIX Labs             |
      | Phone         | 29163024                |
      | Email         | amuhlethaler@vairix.com |
      | Address       | 25 de mayo 555 / 409    |
      | Rut           | 1122332211              |
      | Contact person | Alvaro                 |

    And I press "Save" 
    Then I am on the suppliers page
    And I should see "Labs" supplier

  Scenario: Edit Supplier
    When I am on the suppliers page
    And I follow the "Edit" link for "Quiosko Pepe"
    And I fill in "Phone" with "29101010"
    And I press "Save"
    Then I visit "Quiosko Pepe" supplier details
    And I should see "29101010"

  Scenario: Delete Supplier
    When I am on the suppliers page
    And I follow the "Destroy" link for "Quiosko Pepe"
    And I confirm popup
    Then I am on the suppliers page
    And I should not see "Pepe"

  Scenario: Show Supplier
    When I am on the suppliers page
    And I follow the "Show" link for "Panaderia Santoral"
    Then I should see "Santoral"
    And I should see "29091212"
    And I should see "Carlos"
