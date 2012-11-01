class Product < ActiveRecord::Base
  
  TAXS = [10.0,22.0]

  attr_accessible :description, :name, :price, :supplier_id, :tax

  belongs_to :supplier
  has_many :product_orders
end
