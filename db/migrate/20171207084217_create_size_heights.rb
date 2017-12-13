class CreateSizeHeights < ActiveRecord::Migration
  def change
    create_table :size_heights do |t|
      t.string :height
    end
  end
end
