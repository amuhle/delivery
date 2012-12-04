class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,:supplier_id

  belongs_to :purchase
  belongs_to :supplier
  has_many :orders

  accepts_nested_attributes_for :purchase, :allow_destroy => true
  accepts_nested_attributes_for :supplier, :allow_destroy => true

end
