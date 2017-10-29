ActiveAdmin.register Video do

  permit_params :category_id, :product_id, :user_id,
                :url, :main, :comment, :day, :caption

  controller do
    belongs_to :user, :category, :product, optional: true
  end

  action_item :users, only: :show do
    link_to 'Users', admin_video_users_path(resource)
  end

  filter :main
  filter :day
  filter :comment_cont, label: 'Comment'
  filter :caption_cont, label: 'Caption'
  filter :created_at

  index do
    selectable_column
    id_column
    column :url
    column :main
    column :comment
    column :day
    column :caption
    column :category
    column :product
    column :user
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :product
      f.input :user
      f.input :url
      f.input :main
      f.input :comment
      f.input :day
      f.input :caption
    end
    actions
  end

end
