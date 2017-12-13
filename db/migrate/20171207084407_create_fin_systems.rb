class CreateFinSystems < ActiveRecord::Migration
  def change
    create_table :fin_systems do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
