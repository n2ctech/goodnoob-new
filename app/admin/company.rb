ActiveAdmin.register Company do

  controller do
    belongs_to :user, :distributor, optional: true
  end

  permit_params :name, :url, :description_en, :description_fr, :description_es,
    :international, :email, :phone, :fax, country_ids: [], user_ids: [],
    address_attributes: [:id, :street, :city, :postcode, :country, :country_code,
      :latitude, :longitude, :addressable_type, :addressable_id]

  filter :name_cont, label: 'Name'
  filter :description_en_cont, label: 'Description'
  filter :email_cont, label: 'Email'
  filter :phone_cont, label: 'Phone'
  filter :fax_cont, label: 'Fax'
  filter :created_at

  index do
    id_column
    column :name
    column :url
    column :email
    column :phone
    column :fax
    column :created_at
    column :updated_at
    actions
  end

  action_item :products, only: :show do
    link_to 'Products', admin_company_products_path(company)
  end

  action_item :distributors, only: :show do
    link_to 'Distributors', admin_company_distributors_path(company)
  end

  action_item :users, only: :show do
    link_to 'Users', admin_company_users_path(company)
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      Company.locale_columns(:description).each do |column|
        f.input column, label: column
      end
      f.input :email
      f.input :phone
      f.input :fax
    end

    f.inputs 'Sells in' do
      f.input :countries, as: :check_boxes
    end

    f.inputs 'Address', for: [:address_attributes, f.object.address || f.object.build_address] do |address|
      address.input :id, as: :hidden, value: address.object.id
      address.input :addressable_id, as: :hidden, value: f.object.id
      address.input :addressable_type, as: :hidden, value: 'Company'
      address.input :street
      address.input :postcode
      address.input :city
      address.input :country, as: :string
      address.input :country_code
      address.input :latitude
      address.input :longitude
    end
    f.actions
  end

end
