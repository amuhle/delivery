@javascript
Feature: Manage Orders
  In order to manage orders
  As an User
  I want to create and manage orders

  Background: 
    Given I am a new, authenticated user
    And I have the following clients:
      |name                 |rut      |contact  |address                |email                |phone    | supplier_id |
      |VAIRIX               |19089098 |Alvaro   |25 de mayo 555 of 409  |contacto@vairix.com  |29103024 | 1           |
      |XSeed                |19198980 |Marcelo  |Av. Italia 1223 of 191 |info@xseed.com       |27101200 | 1           |
      |Clinica Muhlethaler  |12322342 |Daniela  |Ellauri 891            |contacto@clinica.com |27110330 | 1           |
    And I have the following orders:
      |notes                          |due_date        |total    |client_id  |user_id |delivery_address |invoice_number|
      |La rucula cortada en trozos    |9/12/2012 16:30 |1300     |1          |1       | Av. Italia 1212 | 1            |
      |Con factura                    |9/12/2012 13:00 |650.50   |2          |1       | Rincon 1212     | 2            |
      |Tomate perita                  |9/13/2012 16:00 |1250     |1          |1       | Av. Italia 1212 | 3            |

  Scenario: Order list
    When I am on the orders page
    Then I should see "rucula, factura" orders

  Scenario: New Order
    When I am on the new order page
    When I check option_name
    And I fill in the following:
      | search_client_name | VAIRIX |
    And I fill in the following:
      | product_name       | Computadora |
      | product_quantity   | 2           |
      | product_price      | 300         |
    And I press "btn_add_product"
    And I fill in the following:
      | order_invoice_number   | 1               |
      | order_notes            | Test New Order  |
      | order_due_date         | 10/1/2012 10:30 |
      | order_total            | 980             |
      | order_delivery_address | Rincon 543      |
    And I press "order_save"
    Then I am on the orders page
    And I should see "Test New Order" order

  Scenario: Edit Order
    When I am on the orders page
    And I follow the "Edit" link for "1"
    And I fill in "Delivery address" with "Buenos Aires 121"
    And I press "Save"
    Then I visit "1" order details
    And I should see "Buenos Aires 121"

  Scenario: Delete Order
    When I am on the orders page
    And I follow the "Destroy" link for "1"
    And I confirm popup
    Then I am on the orders page
    And I should not see "rucula"

  Scenario: Show Order
    When I am on the orders page
    And I follow the "Show" link for "1"
    Then I should see "rucula"
    And I should see "1300"
    And I should see "Av. Italia"