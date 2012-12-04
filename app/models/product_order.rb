class ProductOrder < ActiveRecord::Base
  self.table_name = "products_orders"
  belongs_to :order
  belongs_to :product
  attr_accessible :product_id, :order_id, :quantity, :price
end
