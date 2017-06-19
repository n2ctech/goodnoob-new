class CreateInfoPrivacies < ActiveRecord::Migration
  def change
    create_table :info_privacies do |t|
      t.string :header
      t.text :description

      t.timestamps null: false
    end
  end
end
