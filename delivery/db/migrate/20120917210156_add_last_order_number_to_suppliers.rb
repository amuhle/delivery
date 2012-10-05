class AddLastOrderNumberToSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :last_order_number, :integer, :default => 0
  end
end
