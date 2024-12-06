class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.float :rating
      t.integer :reviews_count
      t.integer :bought_in_past_month
      t.integer :price
      t.integer :discount_price
      t.boolean :free_delivery
      t.integer :stock

      t.timestamps
    end
  end
end
