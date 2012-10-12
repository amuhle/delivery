class AddFinalClientToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :final_client, :string
  end
end
