ActiveAdmin.register FilterOption do

  permit_params :name_en, :name_fr, :name_es, :filter_id

  index do
    id_column
    column :name_en
    column :name_fr
    column :name_es
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :filter
      FilterOption.locale_columns(:name).each do |column|
        f.input column, label: column
      end
    end

    f.actions
  end

end
