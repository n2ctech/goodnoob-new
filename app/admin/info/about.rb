ActiveAdmin.register Info::About do

  permit_params :header_en, :header_fr, :header_es,
    :description_en, :description_fr, :description_es

  filter :header_en
  filter :created_at

  index do
    id_column
    column :header_en
    column :header_fr
    column :header_es
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      Info::About.locale_columns(:header).each do |column|
        f.input column, label: column
      end
      Info::About.locale_columns(:description).each do |column|
        f.input column, label: column, as: :html_editor
      end
    end
    f.actions
  end
end
