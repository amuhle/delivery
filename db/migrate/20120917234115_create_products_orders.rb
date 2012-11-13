class CreateProductsOrders < ActiveRecord::Migration
  def change
    create_table :products_orders do |t|
      t.integer :product_id
      t.integer :order_id
      t.integer :quantity
      t.float :price
    end
  end
end
