class ChangeTotalToOrder < ActiveRecord::Migration
  def up
    change_column :orders, :total, :decimal
  end

  def down
    change_column :orders, :total, :decimal
  end
end
