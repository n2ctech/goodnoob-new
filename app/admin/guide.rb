ActiveAdmin.register Guide do

  belongs_to :sub_category, optional: true

  permit_params :header_en, :header_fr, :header_es,
    :description_en, :description_fr, :description_es,
    :video_url_en, :video_url_fr, :video_url_es,
    :sub_category_id, :image

  filter :header_en
  filter :sub_category
  filter :created_at

  index do
    id_column
    column :header_en
    column(:description) { |g| truncate(g.description, length: 60) }
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :sub_category
      Guide.locale_columns(:video_url).each do |column|
        f.input column, label: column
      end
      Guide.locale_columns(:header).each do |column|
        f.input column, label: column
      end
      Guide.locale_columns(:description).each do |column|
        f.input column, label: column, as: :html_editor
      end
      f.input :image, as: :file
    end
    f.actions
  end

end
