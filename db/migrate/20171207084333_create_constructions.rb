class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
