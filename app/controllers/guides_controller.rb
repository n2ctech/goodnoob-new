class GuidesController < ApplicationController
  before_action :set_sub_category, only: [:show]
  before_action :set_guide, only: [:show]
  before_action :prepare_categories, only: [:show, :index]

  def index
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
