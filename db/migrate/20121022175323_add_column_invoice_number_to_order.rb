class AddColumnInvoiceNumberToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :invoice_number, :integer
  end
end
