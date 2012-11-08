class RenameColumnIdPurchaseToPurchaseId < ActiveRecord::Migration
  def up
    rename_column :transactions, :id_purchase, :purchase_id
  end

  def down
  end
end
