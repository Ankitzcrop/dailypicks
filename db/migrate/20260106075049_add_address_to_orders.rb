class AddAddressToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :address_line1, :string
    add_column :orders, :address_line2, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :pincode, :string
  end
end
