class GuidesController < ApplicationController
  before_action :set_sub_category, only: [:show]
  before_action :set_guide, only: [:show]
  before_action :prepare_categories, only: [:show, :index]

  def index
    # update selected sub category id and category id
    if params[:category_id].nil?
      cookies[:selected_sub_category_id] = 10
      cookies[:selected_category_id] = 4
    else
      cookies[:selected_category_id] = params[:category_id]
      cookies[:selected_sub_category_id] = SubCategory.where(category_id: params[:category_id]).last.id
    end

    return unless params[:category_id]
    @sub_categories = @sub_categories.where(category_id: params[:category_id] || @categories.first.try(:id))
  end

  def show
  end

  private

  def set_sub_category
    @sub_category = SubCategory.includes(:guides).find(params[:sub_category_id])
  end

  def set_guide
    @guide = Guide.find(params[:id])
  end

  def prepare_categories
    @categories = Category.with_guides
    @sub_categories = SubCategory.with_guides
  end
end
