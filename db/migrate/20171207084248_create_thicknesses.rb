class CreateThicknesses < ActiveRecord::Migration
  def change
    create_table :thicknesses do |t|
      t.string :thickness
    end
  end
end
