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
  def show
    @sub_category = SubCategory.find(params[:id])
    params[:sub_categories] = [ @sub_category.id.to_s ]

    product_ids =
      @sub_category.products
                   .base_search(params[:search],
                                params[:sub_categories],
                                params[:companies])
                   .filter(params[:filters])
                   .year_from(params[:year_from])
                   .year_to(params[:year_to])
                   .price_from(params[:price_from])
                   .price_to(params[:price_to])
                   .sort_by(params[:search_field], params[:search_direction])
                   .pluck(:id)

    @products = Product.where(id: product_ids).sort_by('rating', 'true')
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
