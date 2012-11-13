class ChangeQuantityToProductOrder < ActiveRecord::Migration
  def up
    change_column :products_orders, :quantity, :decimal
  end

  def down
    add_column :prducts_orders, :quantity, :integer
  end
end
