class CreatePurchaseTransactions < ActiveRecord::Migration
  def change
    create_table :purchases_transactions do |t|
      t.integer :purchase_id
      t.string :action
      t.integer :amount
      t.boolean :success
      t.string :authorization
      t.string :message
      t.text :params

      t.timestamps
    end
  end
end
