class ChangeQuantityAndPriceToProductsOrders < ActiveRecord::Migration
  def up
    change_column :products_orders, :quantity, :integer
    change_column :products_orders, :price, :decimal
  end

  def down
    add_column :products_orders, :quantity, :integer
    add_column :products_orders, :price, :integer
  end
end
