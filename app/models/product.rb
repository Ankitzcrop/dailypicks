class Product < ApplicationRecord
  belongs_to :subcategory
  belongs_to :seller, class_name: "User", optional: true
  has_many :order_items, dependent: :restrict_with_error

  validates :name, :price, :stock_quantity, presence: true
  has_one_attached :image 
end
