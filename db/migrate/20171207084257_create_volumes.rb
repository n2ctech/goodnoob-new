class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
      t.string :volume
    end
  end
end
