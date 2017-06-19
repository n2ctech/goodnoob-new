# == Schema Information
#
# Table name: pictures
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class PicturesController < ApplicationController
  include ImitateDelay
  imitate_delay only: :create
  before_filter :destroy_old_picture, only: :create

  def create
    picture = Picture.new creation_params
    if picture.save
      redirect_to edit_user_registration_path
    else
      render 'shared/errors', locals: { errors: picture.errors }
    end
  end

  private

  def creation_params
    params.require(:picture).permit %i(title imageable_type imageable_id image)
  end

  def destroy_old_picture
    old_picture = Picture.where(imageable_type: params[:picture][:imageable_type], imageable_id: params[:picture][:imageable_id]).last
    old_picture.destroy if old_picture
  end
end
