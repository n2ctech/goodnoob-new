ActiveAdmin.register Artwork do
  permit_params :id, :price, picture_attributes: [:image, :_destroy, :id]

  form do |f|
    f.input :price

    f.inputs 'Image', for: [:picture, f.object.picture || Picture.new] do |img|
      img.input :image, required: true, as: :file,
                hint: (image_tag img.object.url :thumbnail if img.object.persisted?)
    end

    f.actions
  end

end
