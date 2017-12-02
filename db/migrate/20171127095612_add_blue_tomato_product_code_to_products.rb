class AddBlueTomatoProductCodeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :blue_tomato_product_code, :string
    add_index :products, :blue_tomato_product_code, unique: true
  end
end
