class CreateTailShapes < ActiveRecord::Migration
  def change
    create_table :tail_shapes do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
    end
  end
end
