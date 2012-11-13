class ChangeColumnActiveToOrdres < ActiveRecord::Migration
  def up
    change_column :orders, :active, :boolean, default: true
  end

  def down
    change_column :orders, :active, :bollean, default: true
  end
end
