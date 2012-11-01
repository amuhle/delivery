class AddRutAndContactToClients < ActiveRecord::Migration
  def change
    add_column :clients, :rut, :string
    add_column :clients, :contact, :string
  end
end
