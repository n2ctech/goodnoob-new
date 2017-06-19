class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :header
      t.text :description

      t.timestamps null: false
    end
  end
end
