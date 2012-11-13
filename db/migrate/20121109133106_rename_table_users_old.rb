class RenameTableUsersOld < ActiveRecord::Migration
  def up
    rename_table :users_old, :users
  end

  def down
  end
end
