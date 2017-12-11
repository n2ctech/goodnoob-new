class CreateArtworks < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
