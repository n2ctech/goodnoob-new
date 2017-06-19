class CreateGuides < ActiveRecord::Migration
  def change
    create_table :guides do |t|
      t.string :header
      t.text :description
      t.string :video_url

      t.timestamps null: false
    end
  end
end
