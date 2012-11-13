class AddColumnTaxToProduct < ActiveRecord::Migration
  def change
    add_column :products, :tax, :integer
  end
end
