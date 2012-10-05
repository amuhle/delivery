class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :supplier_id

  belongs_to :supplier
  has_many :product_orders
end
