class AddColumnsStatusAndPayAndActiveToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :status, :string, default: 'Pending'
    add_column :orders, :pay, :boolean, default: false
    add_column :orders, :active, :boolean, default: false
  end
end
