class CreateSurfboardDetails < ActiveRecord::Migration
  def change
    create_table :surfboard_details do |t|
      t.integer :product_id
      t.string :perfect_for
      t.string :perfecto_para
      t.string :parfait_pour

      t.string :manufacturing_time_en
      t.string :manufacturing_time_es
      t.string :manufacturing_time_fr

      t.string :rocker_en
      t.string :rocker_es
      t.string :rocker_fr

      t.string :rails_en
      t.string :rails_es
      t.string :rails_fr

      t.string :concave_en
      t.string :concave_es
      t.string :concave_fr

      t.string :wave_size_en
      t.string :wave_size_es
      t.string :wave_size_fr
    end
  end
end
