class Supplier < ActiveRecord::Base
  attr_accessible :address, :contact_person, :email, :name, :phone, :rut

  validates :rut, presence:  true

  has_one :admins
  has_many :clients
  has_many :products
  has_many :users
end
