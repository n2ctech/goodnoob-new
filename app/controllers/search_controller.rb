class SearchController < ApplicationController
  def index
    @filters = SearchFilter.build params
    @media = Kaminari.paginate_array(ProductSearchService.new(params).search.media)
               .page(params[:page])
               .per(16)
    current_user.remove_search(params[:delete_search]) if params[:delete_search]
    current_user.save_search(params[:search]) if user_signed_in? and params[:search]

    respond_to do |format|
      format.js { render 'search_results_callback', layout: false }
      format.html do
        @categories = Category.includes(:sub_categories).order(:id)
      end
    end
  end

  def suggestions
    @suggestions = ProductSearchService.new(params).suggestions
    respond_to do |format|
      format.json do
        render json: @suggestions,
               layout: false
      end
    end
  end

  def remove
    current_user.remove_search(params[:id]) if current_user
    if request.xhr?
      head 200
    else
      redirect_to :back
    end
  end

end
