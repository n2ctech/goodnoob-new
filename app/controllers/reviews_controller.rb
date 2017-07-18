# == Schema Information
#
# Table name: reviews
#
#  id          :integer          not null, primary key
#  title       :string
#  review      :text
#  language_id :integer
#  user_id     :integer
#  product_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ReviewsController < ApplicationController
  before_action :set_product
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @product = Product.find params[:product_id]
    @pictures = @product.pictures.order(created_at: :asc).first(6)
    @reviews = @product.reviews #.recent.first(3)
    @simpage = (params[:similar] || '1').to_i
  end

  def new
    @review = Review.new
    @review.rating = Rating.where({user_id: current_user.id, product_id: params[:product_id]})
                           .first_or_initialize
    @review.rating.value ||= Rating::DEFAULT_VALUE
  end

  def create
    @review = Review.new(review_params.merge(review_extra_params))
    if rating = Rating.find_by_id(rating_params[:id])
      @review.rating = rating
    else
      @review.build_rating
    end
    @review.rating.value = rating_params[:value]

    if @review.save!
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def edit
  end

  def update
    if @review.update(review_params)
      # redirect_to product_reviews_path(@product)
      redirect_to edit_user_registration_path
    else
      render :edit
    end
  end

  def destroy
    @review.destroy!
    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_review
    @review = @product.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :review)
  end

  def rating_params
    params.require(:review).permit(rating_attributes: [:value, :id])["rating_attributes"]
  end

  def review_extra_params
    { user_id: current_user.id,
      product_id: @product.id,
      language_id: current_user.language_id || 1 }
  end
end
