class Order < ActiveRecord::Base

  STATUS = ['Pending','Delivered','Delayed']

  scope :last_twenty, order(:created_at).limit(20)

  before_create :set_supplier_and_order_number
  after_create :set_last_order_number

  belongs_to :client
  belongs_to :user
  belongs_to :admin
  belongs_to :supplier
  has_many :product_orders

  attr_accessible :delivery_address, :due_date, :notes, :total, :supplier_id, :client_id, :user_id, :final_client, :status, :pay, :active, :invoice_number, :admin_id
  attr_accessor :product

  def product_name
    product 
  end

  def product_name=(value)
    product = value
  end

  private

  def set_supplier_and_order_number
    if self.user.nil?
      self.supplier = self.admin.supplier
    else
      self.supplier = self.user.supplier
    end
    self.number   = self.supplier.last_order_number + 1
  end

  def set_last_order_number
    self.supplier.last_order_number = self.number
    self.supplier.save!
  end
end
