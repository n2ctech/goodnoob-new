class GuideImagesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    image = GuideImage.create image: params[:file]
    render json: { id: image.id, url: image.image_url }
  end

end
