class AddCompaniesCountries < ActiveRecord::Migration
  def change
    create_table :companies_countries do |t|
      t.references :country, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
