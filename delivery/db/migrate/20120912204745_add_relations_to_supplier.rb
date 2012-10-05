class AddRelationsToSupplier < ActiveRecord::Migration
  def change
    add_column :users, :supplier_id, :integer
    add_column :clients, :supplier_id, :integer
    add_column :products, :supplier_id, :integer

    add_index :users, :supplier_id
    add_index :clients, :supplier_id
    add_index :products, :supplier_id
  end
end
