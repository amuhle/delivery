class Client < ActiveRecord::Base
  attr_accessible :address, :rut, :contact, :email, :name, :phone
end
