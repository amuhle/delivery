class DropTableAdmins < ActiveRecord::Migration
  def up
    drop_table :admins
  end

  def down
    create_table :admins do |t|
      t.string :email
      t.string :encrypted_password
      t.timestamps
    end
  end
end
