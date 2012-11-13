class Client < ActiveRecord::Base
  attr_accessible :address, :rut, :contact, :email, :name, :phone, :supplier_id
  
  belongs_to :supplier

   validates_uniqueness_of :phone, :rut
end
