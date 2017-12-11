class CreateSizeWidths < ActiveRecord::Migration
  def change
    create_table :size_widths do |t|
      t.string :width
    end
  end
end
