# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  main        :boolean
#  comment     :text
#  day         :boolean
#  product_id  :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class PhotosController < ApplicationController
  include ImitateDelay
  imitate_delay only: :create

  before_action :authenticate_user!, only: [:create]
  before_action :set_photo, only:[:show]
  before_action :set_product, only:[:show]

  def show
    @other_media = @product.photos + @product.videos
    @other_media = @other_media.sort_by(&:created_at).reverse!
  end

  def create
    product = Product.find(creation_params[:product_id])
    photo = Photo.new creation_params.merge \
                      main: false, day: false, user: current_user,
                      category_id: product.category.id

    if photo.save
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: photo.errors }
    end
  end

  def edit
    @photo = current_user.photos.find params[:id]

    respond_to do |format|
      format.json {}
    end
  end

  def update
    @photo = current_user.photos.find params[:id]

    if @photo.update(update_params)
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: @photo.errors }
    end
  end

  def destroy
    photo = current_user.photos.find params[:id]
    photo.destroy!
    redirect_to :back
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_product
    @product = @photo.product
  end

  def creation_params
    params.require(:photo).permit %i(comment product_id),
                                  picture_attributes: %i(title image)
  end

  def update_params
    if creation_params[:picture_attributes].empty?
      creation_params.except 'picture_attributes'
    else
      creation_params
    end
  end
end
