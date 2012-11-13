class CreateTableAdmin < ActiveRecord::Migration
  create_table :admins do |t|
    t.string :email
    t.string :encrypted_password
    t.timestamps
  end
end
