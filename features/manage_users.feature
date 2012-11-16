@javascript
Feature: Manage User
  In order to manage users
  As an Admin
  I want to create and manage users

  Background:
    Given I have the following users:
      | email                 |password  | password_confirmation  | supplier_id |
      | prueba1@prueba.com    |prueba1   | prueba1                | 1           |
      | prueba2@prueba.com    |prueba2   | prueba2                | 1           |
      | prueba3@prueba.com    |prueba3   | prueba3                | 1           |
    And I am a new, authenticated admin

  Scenario: Users list
    When I am on the users page
    Then I should see "prueba1@prueba.com,prueba2@prueba.com,prueba3@prueba.com" users

  Scenario: New User
    When I am on the new user page
    And I fill in the following:
      | user_email                 | prueba4@prueba.com |
      | user_password              | prueba             |
      | user_password_confirmation | prueba             |

    And I press "user_save"
    Then I am on the users page
    And I should see "prueba4@prueba" user

  Scenario: Edit User
    When I am on the users page
    And I follow the "user_edit" link for "prueba1@prueba.com"
    And I fill in "user_email" with "prueba11@prueba.com"
    And I fill in "user_password" with "prueba"
    And I fill in "user_password_confirmation" with "prueba"
    And I press "user_save"
    Then I visit "prueba11@prueba.com" user details

  Scenario: Delete User
    When I am on the users page
    And I follow the "user_destroy" link for "prueba3@prueba.com"
    And I confirm popup
    Then I am on the users page
    And I should not see "prueba3@prueba.com"

  Scenario: Show Product
    When I am on the users page
    And I follow the "user_show" link for "prueba2@prueba.com"
    Then I should see "prueba2@prueba.com"

  Scenario: New User with errors
    When I am on the new user page
    And I fill in the following:
      | user_email                 | |
      | user_password              | |
      | user_password_confirmation | |

    And I press "user_save"
    Then the field "user_email" should have the error "Email no puede estar en blanco"
    And the field "user_password" should have the error "Password no puede estar en blanco"


