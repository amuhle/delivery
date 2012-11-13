class AddNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :number, :integer
    add_index :orders, :number
  end
end
