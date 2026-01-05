class AddSubcategoryToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :subcategory, null: true, foreign_key: true
  end
end
