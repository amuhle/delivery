class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.text :notes
      t.date :due_date
      t.integer :total
      t.references :client
      t.references :user
      t.references :supplier
      t.string :delivery_address

      t.timestamps
    end
    add_index :orders, :client_id
    add_index :orders, :user_id
    add_index :orders, :supplier_id
  end
end
