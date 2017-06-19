class ChangeLanguageToLocaleForUsers < ActiveRecord::Migration
  def change
    rename_column :users, :language, :locale
  end
end
