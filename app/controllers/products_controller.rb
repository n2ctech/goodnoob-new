# == Schema Information
#
# Table name: products
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  year            :integer
#  url             :string
#  sub_category_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  company_id      :integer
#

class ProductsController < ApplicationController
  include HelperAttr

  helper_attr :product, :pictures, :reviews, :photos, :videos, :similars

  def show
    @product = Product.find params[:id]
    country = Country.find_by(country_code: @user_country) || Country.find_by(country_code: 'US')
    region = country&.region
    @buy_url = @product.region_product_urls.find_by region: region

    @media = (product.photos + product.videos).sort_by(&:created_at).reverse
    @pictures = product.pictures.order(created_at: :asc).first(6)
    @reviews = product.reviews.where.not(review: " ").order(created_at: :asc).first(3)
    @simpage = (params[:similar] || '1').to_i
    @filters = product.filter_options.map(&:filter).uniq.sort { |x, y| x['name'] <=> y['name'] }
    if @simpage == 1
      @similars = Kaminari.paginate_array(product.similars.recent)
                     .page(@simpage)
                     .per(3)
    else
      @similars = Kaminari.paginate_array(product.similars.recent)
                     .page(@simpage)
                     .per(10)
    end
    @photopage = (params[:photo] || '1').to_i
    if @photopage == 1
      @photos = Kaminari.paginate_array(product.photos.recent)
                     .page(@photopage)
                     .per(2)
    else
      @photos = Kaminari.paginate_array(product.photos.recent)
                     .page(@photopage)
                     .per(10)
    end
    @videopage = (params[:video] || '1').to_i
    if @videopage == 1
      @videos = Kaminari.paginate_array(product.videos.recent)
                     .page(@videopage)
                     .per(2)
    else
      @videos = Kaminari.paginate_array(product.videos.recent)
                     .page(@videopage)
                     .per(10).padding(-8)
    end
    respond_to do |format|
      format.js do
        if params[:media].present?
          render 'product_media_callback', layout: false
        end
        if params[:similar]
          render partial: 'product_similar', locals: { results: @similars }
        end
        if params[:photo]
          render partial: 'product_photo', locals: { results: @photos }
        end
        if params[:video]
          render partial: 'product_video', locals: { results: @videos }
        end
      end

      format.html
    end
  end

    def set_filter_options
      @product = Product.find(params[:product_id]) if params[:product_id].present?

      sub_category = SubCategory.find(params[:id])
      @filter_options = sub_category.filter_options

      respond_to do |format|
         format.html { render :layout => false }
         format.js {}
      end
    end

  def ajax_set_product_rating
    success = true
    error_msg = ""

    rating_field = Rating.where({user_id: current_user.id, product_id: params[:product_id]}).first_or_create do |record|
      record.user_id = current_user.id
      record.product_id = params[:product_id]

      record.review = Review.new({user_id: current_user.id, product_id: params[:product_id], language_id: current_user.language_id, title: " ", review: " ", rating: record})
      if record.review.save({validate: false}) == false
        errror_msg = record.review.errors.full_messages
        puts error_msg
      end
    end

    if success
      rating_field.value = params[:rating]
      success = rating_field.save({validate: false})
    end

    if success
      render json: { rating: params[:rating], status: 200 }, status: 200
    else
      error_msg = rating_field.errors.full_messages
      render json: { error: error_msg, status: 400}, status: 400
    end

  end
end
