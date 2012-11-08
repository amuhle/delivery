class ChangeColumnnIpAddresToPurchase < ActiveRecord::Migration
  def up
    rename_column :purchases, :ip_addres, :ip_address
  end

  def down
  end
end
