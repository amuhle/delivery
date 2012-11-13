class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :address
      t.string :rut
      t.string :contact_person

      t.timestamps
    end
  end
end
