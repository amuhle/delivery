class AddColumnSupplierIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :supplier_id, :integer
  end
end
