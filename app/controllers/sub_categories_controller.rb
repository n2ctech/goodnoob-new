# == Schema Information
#
# Table name: sub_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SubCategoriesController < ApplicationController
  protect_from_forgery except: :show

  def show
    # update selected sub category id and category id
    if params[:id].nil?
      cookies[:selected_sub_category_id] = 10
      cookies[:selected_category_id] = 4
    else
      cookies[:selected_sub_category_id] = params[:id]
      cookies[:selected_category_id] = SubCategory.find(params[:id]).category_id
    end

    if session[:country_id].nil?
      @country_id = 1
    else
      @country_id = session[:country_id]
    end

    @sub_category = SubCategory.find(params[:id])
    params[:sub_categories] = [ @sub_category.id.to_s ]

    @products =
      @sub_category.products
                   .includes(:company)
                   .base_search(params[:search],
                                params[:sub_categories],
                                params[:companies])
                   .filter(params[:filters])
                   .year_from(params[:year_from])
                   .year_to(params[:year_to])
                   .price_from(params[:price_from])
                   .price_to(params[:price_to])
                   .sort_by(params[:search_field], params[:search_direction])
                   .page(params[:page])
                   .per(16)

    @filters = @sub_category.filters

    @categories = Category.includes(:sub_categories).order(:id)

    respond_to do |format|
      format.js { render 'success', layout: false }
      format.html
    end
  end
end
