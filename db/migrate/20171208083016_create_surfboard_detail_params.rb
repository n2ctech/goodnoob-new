class CreateSurfboardDetailParams < ActiveRecord::Migration
  def change
    create_table :surfboard_detail_params do |t|
      t.belongs_to :surfboard_detail

      t.belongs_to :size_height
      t.belongs_to :size_width
      t.belongs_to :thickness
      t.belongs_to :volume
      t.belongs_to :tail_shape
      t.belongs_to :construction
      t.belongs_to :fin_system
      t.belongs_to :artwork
    end
  end
end
