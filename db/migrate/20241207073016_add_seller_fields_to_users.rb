class AddSellerFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :mobile, :string
    add_column :users, :store_name, :string
    add_column :users, :business_name, :string
    add_column :users, :tax_identification_number, :string
    add_column :users, :philippine_government_id_card, :string
    add_column :users, :address_proof, :string
    add_column :users, :logo, :string
    add_column :users, :region, :string
    add_column :users, :city, :string
    add_column :users, :barangay, :string
    add_column :users, :dti_sec_registration_number, :string
    add_column :users, :agreement, :boolean
    add_column :users, :seller, :boolean
  end
end
