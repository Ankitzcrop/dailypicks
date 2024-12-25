class AddRemainingFieldsToProducts < ActiveRecord::Migration[7.0]
  def change
    # General Fields
    add_column :products, :description, :text
    add_column :products, :category, :string
    add_column :products, :subcategory, :string
    add_column :products, :tags, :string, array: true, default: []

    # Pricing and Availability Fields
    change_column :products, :price, :decimal, precision: 10, scale: 2
    change_column :products, :discount_price, :decimal, precision: 10, scale: 2
    add_column :products, :stock_quantity, :integer
    add_column :products, :unit, :string
    add_column :products, :availability_status, :boolean, default: true
    add_column :products, :delivery_time, :string

    # Image and Media Fields
    add_column :products, :thumbnail_url, :string
    add_column :products, :video_url, :string

    # Search and Filter Fields
    add_column :products, :brand, :string
    add_column :products, :product_origin, :string
    add_column :products, :dietary_info, :string, array: true, default: []

    # Metadata for Management
    add_column :products, :seller_id, :integer
    add_column :products, :is_featured, :boolean, default: false
    
  end
end
