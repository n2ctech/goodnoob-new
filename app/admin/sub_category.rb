ActiveAdmin.register SubCategory do

  belongs_to :category, optional: true

  permit_params :name_en, :name_fr, :name_es, :category_id,
                       filters_attributes: %i(id sub_category_id name_en name_fr name_es _destroy),
                       picture_attributes: %i(id imageable_id imageable_type image)

  filter :name_en
  filter :category
  filter :created_at

  action_item :products, only: :show do
    link_to 'Products', admin_sub_category_products_path(sub_category)
  end

  action_item :guides, only: :show do
    link_to 'Guides', admin_sub_category_guides_path(sub_category)
  end

  index do
    id_column
    column :name_en
    column :name_fr
    column :name_es
    column :category
    column :created_at
    column :updated_at
    actions
  end

  show do |order|
    attributes_table do
      row :name_en
      row :name_fr
      row :name_es
      row :category
    end
    table_for sub_category.filters, sortable: true, class: 'index_table' do
      column :filters do |fo|
        fo.name
      end
    end
  end

  sidebar :picture, only: :show do
    image_tag sub_category.picture_url :thumbnail
  end

  form do |f|
    f.inputs do
      f.input :category
      SubCategory.locale_columns(:name).each do |column|
        f.input column, label: column
      end
    end

    f.inputs 'Picture', for: [:picture_attributes, f.object.picture || f.object.build_picture] do |p|
      p.input :id, as: :hidden, value: p.object.id
      p.input :imageable_id, as: :hidden, value: f.object.id
      p.input :imageable_type, as: :hidden, value: 'SubCategory'
      p.input :image, required: true, as: :file,
                      hint: (image_tag p.object.url :thumbnail if p.object.persisted?)
    end

    f.inputs "Filters" do
      f.has_many :filters, allow_destroy: true, new_record: true do |fo|
        Filter.locale_columns(:name).each do |column|
          fo.input column, label: column
        end
      end
    end

    f.actions
  end

end
