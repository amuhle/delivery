class Product < ActiveRecord::Base
  attr_accessible :description, :name, :price, :supplier_id

  belongs_to :supplier
end
