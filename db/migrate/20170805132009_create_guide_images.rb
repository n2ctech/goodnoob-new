class CreateGuideImages < ActiveRecord::Migration
  def change
    create_table :guide_images do |t|
      t.string :image

      t.timestamps null: false
    end
  end
end
