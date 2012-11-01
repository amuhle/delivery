@javascript
Feature: Manage Products
  In order to manage products
  As an User
  I want to create and manage products

  Background:
    Given I have the following products:
      |name                 |description        |price    | supplier_id |
      |pencil               |blue pencil uni    |45.50    | 1           |
      |notebook             |macbook pro        |1299.00  | 1           |
      |eraser               |White eraser gummy |15.00    | 1           |
    And I am a new, authenticated user

  Scenario: Product list
    When I am on the products page
    Then I should see "pencil, notebook, eraser" products

  Scenario: New Product
    When I am on the new product page
    And I fill in the following:
      | Name        | calculator             |
      | Description | cientific calculator   |
      | Price       | 650.00                 |

    And I press "Save" 
    Then I am on the products page
    And I should see "calculator" product

  Scenario: Edit Product
    When I am on the products page
    And I follow the "Edit" link for "pencil"
    And I fill in "Description" with "white pencil uni"
    And I press "Save"
    Then I visit "pencil" product details
    And I should see "white pencil uni"

  Scenario: Delete Product
    When I am on the products page
    And I follow the "Destroy" link for "pencil"
    And I confirm popup
    Then I am on the products page
    And I should not see "pencil"

  Scenario: Show Product
    When I am on the products page
    And I follow the "Show" link for "pencil"
    Then I should see "blue pencil uni"
    And I should see "pencil"
    And I should see "45.5"
