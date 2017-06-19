class AddTranslationColumnToCategories < ActiveRecord::Migration
  def change
    rename_column :categories, :name, :name_en
    add_column :categories, :name_fr, :string
    add_column :categories, :name_es, :string

    rename_column :companies, :description, :description_en
    add_column :companies, :description_fr, :text
    add_column :companies, :description_es, :text

    rename_column :distributors, :information, :information_en
    add_column :distributors, :information_fr, :text
    add_column :distributors, :information_es, :text

    rename_column :father_categories, :name, :name_en
    add_column :father_categories, :name_fr, :string
    add_column :father_categories, :name_es, :string

    rename_column :filters, :name, :name_en
    add_column :filters, :name_fr, :string
    add_column :filters, :name_es, :string

    rename_column :filter_options, :name, :name_en
    add_column :filter_options, :name_fr, :string
    add_column :filter_options, :name_es, :string

    rename_column :guides, :video_url, :video_url_en
    add_column :guides, :video_url_fr, :string
    add_column :guides, :video_url_es, :string
    rename_column :guides, :header, :header_en
    add_column :guides, :header_fr, :string
    add_column :guides, :header_es, :string
    rename_column :guides, :description, :description_en
    add_column :guides, :description_fr, :text
    add_column :guides, :description_es, :text

    rename_column :info_abouts, :header, :header_en
    add_column :info_abouts, :header_fr, :string
    add_column :info_abouts, :header_es, :string
    rename_column :info_abouts, :description, :description_en
    add_column :info_abouts, :description_fr, :text
    add_column :info_abouts, :description_es, :text

    rename_column :info_questions, :header, :header_en
    add_column :info_questions, :header_fr, :string
    add_column :info_questions, :header_es, :string
    rename_column :info_questions, :description, :description_en
    add_column :info_questions, :description_fr, :text
    add_column :info_questions, :description_es, :text

    rename_column :products, :description, :description_en
    add_column :products, :description_fr, :text
    add_column :products, :description_es, :text

    rename_column :languages, :name, :name_en
    add_column :languages, :name_fr, :string
    add_column :languages, :name_es, :string

    rename_column :sub_categories, :name, :name_en
    add_column :sub_categories, :name_fr, :string
    add_column :sub_categories, :name_es, :string

    rename_column :attributes, :title, :title_en
    add_column :attributes, :title_fr, :string
    add_column :attributes, :title_es, :string
    rename_column :attributes, :value, :value_en
    add_column :attributes, :value_fr, :string
    add_column :attributes, :value_es, :string
  end
end
