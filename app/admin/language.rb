ActiveAdmin.register Language do

  permit_params :name_en, :name_fr, :name_es

  filter :name_en

end
