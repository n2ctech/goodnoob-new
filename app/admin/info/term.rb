ActiveAdmin.register Info::Term do

  permit_params :header, :description

  filter :header
  filter :created_at

  index do
    id_column
    column :header
    column(:description) { |g| truncate(g.description, length: 60) }
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :header
      f.input :description, as: :html_editor
    end
    f.actions
  end
end
