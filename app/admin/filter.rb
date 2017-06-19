ActiveAdmin.register Filter do
  permit_params :name_en, :name_fr, :name_es, :sub_category_id,
                filter_options_attributes: [:id, :filter_id, :name_en,
                  :name_fr, :name_es, :_destroy]

  index do
    id_column
    column :name_en
    column :name_fr
    column :name_es
    column :created_at
    column :updated_at
    actions
  end


  show do |order|
    attributes_table do
      row :name_en
      row :name_fr
      row :name_es
      row :sub_category
    end
    table_for filter.filter_options, sortable: true, class: 'index_table' do
      column :filter_options do |fo|
        fo.name
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :sub_category
      Filter.locale_columns(:name).each do |column|
        f.input column, label: column
      end
    end

    f.inputs "Filter Options" do
      f.has_many :filter_options, allow_destroy: true, new_record: true do |fo|
        FilterOption.locale_columns(:name).each do |column|
          fo.input column, label: column
        end
      end
    end

    f.actions

  end

end
