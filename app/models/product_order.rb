class ProductOrder < ActiveRecord::Base
  set_table_name :products_orders

  attr_accessible :product_id, :order_id, :quantity, :price
end
