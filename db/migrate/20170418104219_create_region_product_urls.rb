class CreateRegionProductUrls < ActiveRecord::Migration
  def change
    create_table :region_product_urls do |t|
      t.references :region, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.string :url

      t.timestamps null: false
    end

    add_index :region_product_urls, [:product_id, :region_id], unique: true
  end
end
