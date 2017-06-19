# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  url         :string
#  main        :boolean
#  comment     :text
#  day         :boolean
#  caption     :string
#  product_id  :integer
#  user_id     :integer
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  host        :string(10)
#  code        :string(20)
#

class VideosController < ApplicationController
  include ImitateDelay
  imitate_delay only: :create

  before_action :authenticate_user!, only: [:create]
  before_action :set_video, only:[:show]
  before_action :set_product, only:[:show]

  def show
    @other_media = @product.photos + @product.videos
    @other_media = @other_media.sort_by(&:created_at).reverse!
  end

  def create
    video = Video.new creation_params.merge! main: false, day: false, user: current_user
    if video.save
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: video.errors }
    end
  end

  # GET /videos/:id/edit
  def edit
    @video = current_user.videos.find params[:id]

    respond_to do |format|
      format.json {}
    end
  end

  # PATCH /videos/:id
  def update
    @video = current_user.videos.find params[:id]
    if @video.update_attributes(creation_params)
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: @video.errors }
    end
  end

  # DELETE /videos/:id
  def destroy
    video = current_user.videos.find params[:id]
    video.destroy!
    redirect_to :back
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def set_product
    @product = @video.product
  end

  def creation_params
    params.require(:video).permit %i(url title comment product_id category_id)
  end
end
