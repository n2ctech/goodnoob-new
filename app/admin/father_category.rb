ActiveAdmin.register FatherCategory do

  permit_params :name_en, :name_fr, :name_es

  filter :name_en
  filter :created_at

  action_item :categories, only: :show do
    link_to 'Categories', admin_father_category_categories_path(father_category)
  end

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
      FatherCategory.locale_columns(:name).each do |column|
        f.input column, label: column
      end
    end
    f.actions
  end


end
