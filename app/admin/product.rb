ActiveAdmin.register Product do

  controller do
    belongs_to :company, :user, :sub_category, optional: true

    def edit
      gon.product_id = params[:id]
      super
    end
  end

  permit_params :name, :description_en, :description_fr, :description_es, :year,
                :sub_category_id, :company_id,
                attrs_attributes: [:title_en, :title_fr, :title_es,
                 :value_en, :value_es, :value_fr, :_destroy, :id],
                prices_attributes: [:amount, :currency_id, :_destroy, :id],
                dimensions_attributes: [:text, :_destroy, :id],
                pictures_attributes: [:image, :_destroy, :id],
                region_product_urls_attributes: [:url, :_destroy, :id, :region_id],
                :filter_option_ids => [],
                :surfboard_detail_attributes => [
                  :id,
                  :perfect_for,
                  :perfecto_para,
                  :parfait_pour,

                  :manufacturing_time_en,
                  :manufacturing_time_es,
                  :manufacturing_time_fr,

                  :rocker_en,
                  :rocker_es,
                  :rocker_fr,

                  :rails_en,
                  :rails_es,
                  :rails_fr,

                  :concave_en,
                  :concave_es,
                  :concave_fr,

                  :wave_size_en,
                  :wave_size_es,
                  :wave_size_fr,

                  :surfboard_detail_params_attributes => [
                    :id,
                    :size_height_id,
                    :size_width_id,
                    :thickness_id,
                    :volume_id,
                    :tail_shape_id,
                    :construction_id,
                    :fin_system_id,
                    :artwork_id,
                    :_destroy
                  ]
                ]

  action_item :videos, only: :show do
    link_to 'Videos', admin_product_videos_path(product)
  end

  action_item :photos, only: :show do
    link_to 'Photos', admin_product_photos_path(product)
  end

  action_item :ratings, only: :show do
    link_to 'Ratings', admin_product_ratings_path(product)
  end

  action_item :reviews, only: :show do
    link_to 'Reviews', admin_product_reviews_path(product)
  end

  action_item :users, only: :show do
    link_to 'Users', admin_product_users_path(product)
  end

  filter :name_cont, label: 'Name'
  filter :description_en_cont, label: 'Description'
  filter :year
  filter :sub_category
  filter :company

  index do
    id_column
    column :name
    column :year
    column :sub_category
    column :company
    column :created_at
    column :updated_at
    actions
  end

  show do
    panel 'Product Name' do
      attributes_table_for product do
        row :name
        row :description_en
        row :description_fr
        row :description_es
        row :year
        row :sub_category
        row :created_at
        row :updated_at
        row :company
      end
    end
    panel 'Pictures' do
      table_for product.pictures do
        column { |p| image_tag p.url :thumbnail }
      end
    end
    panel 'Prices' do
      table_for product.prices do
        column :amount
        column :currency
      end
    end
    panel 'Region Product URLs' do
      table_for product.region_product_urls do
        column :url
        column :region
      end
    end
    panel 'Attributes' do
      table_for product.attrs do
        column :title
        column :value
      end
    end
    panel 'Dimenstions' do
      table_for product.dimensions do
        column :text
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      Product.locale_columns(:description).each do |column|
        f.input column, label: column
      end
      f.input :year
      f.input :company
      f.input :sub_category
      f.input :filter_options, as: :grouped_check_boxes,
                               collection: FilterOption.includes(:filter).all.group_by(&:filter),
                               label: 'Filter Options'
    end

    f.inputs 'Details', for: [:surfboard_detail, f.object.surfboard_detail || SurfboardDetail.new], 'data-type' => 'product_details' do |d|
      d.input :perfect_for
      d.input :perfecto_para
      d.input :parfait_pour

      d.input :manufacturing_time_en
      d.input :manufacturing_time_es
      d.input :manufacturing_time_fr

      d.input :rocker_en
      d.input :rocker_es
      d.input :rocker_fr

      d.input :rails_en
      d.input :rails_es
      d.input :rails_fr

      d.input :concave_en
      d.input :concave_es
      d.input :concave_fr

      d.input :wave_size_en
      d.input :wave_size_es
      d.input :wave_size_fr

      d.has_many :surfboard_detail_params, allow_destroy: true do |attr|
        attr.input :size_height
        attr.input :size_width
        attr.input :thickness
        attr.input :volume
        attr.input :tail_shape
        attr.input :construction
        attr.input :fin_system
        attr.input :artwork, as: :select, include_blank: true,
                   collection: Artwork.all.map{|item| [item.id, item.id, {'data-imagesrc' => item.picture.url}]},
                   input_html: {'data-type' => 'ddslick'}
      end
    end

    f.inputs 'Pictures' do
      f.has_many :pictures, allow_destroy: true do |attr|
        attr.input :image, required: true, as: :file,
                           hint: (image_tag attr.object.url :thumbnail if attr.object.persisted?)
      end
    end
    f.inputs 'Prices' do
      f.has_many :prices, allow_destroy: true do |attr|
        attr.input :amount
        attr.input :currency
      end
    end
    f.inputs 'Region Product URLs' do
      f.has_many :region_product_urls, allow_destroy: true do |attr|
        attr.input :url
        attr.input :region
      end
    end
    f.inputs 'Attributes' do
      f.has_many :attrs, allow_destroy: true do |attr|
        Attribute.locale_columns(:title).each do |column|
          attr.input column, label: column
        end
        Attribute.locale_columns(:value).each do |column|
          attr.input column, label: column
        end
      end
    end
    f.inputs 'Dimensions' do
      f.has_many :dimensions, allow_destroy: true do |attr|
        attr.input :text
      end
    end
    f.actions
  end

end
