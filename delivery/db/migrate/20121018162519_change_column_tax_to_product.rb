class ChangeColumnTaxToProduct < ActiveRecord::Migration
  def up
    change_column :products, :tax, :decimal
  end

  def down
    change_column :products, :tax, :decimal
  end
end
