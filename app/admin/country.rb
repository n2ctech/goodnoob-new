ActiveAdmin.register Country do

  permit_params :name, :country_code, :region_id, :currency_id, :language_id

end
