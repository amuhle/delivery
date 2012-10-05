class ChangeDueDateType < ActiveRecord::Migration
  def up
    change_column :orders, :due_date, :datetime
  end

  def down
    change_column :orders, :due_date, :date
  end
end
