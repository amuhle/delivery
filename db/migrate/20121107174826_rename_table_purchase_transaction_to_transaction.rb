class RenameTablePurchaseTransactionToTransaction < ActiveRecord::Migration
  def up
    rename_table :purchases_transactions, :transactions
  end

  def down
  end
end
