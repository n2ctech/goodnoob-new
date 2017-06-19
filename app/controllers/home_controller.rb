class HomeController < ApplicationController

    def index
        set_categories
        set_filters
    end

    def welcome_page
      redirect_to action: :index if user_signed_in?
    end

    private

    def set_categories
        @categories ||= Category.includes(:sub_categories).order(:id)
    end

    def set_filters
        @filters = SearchFilter.build params
    end
end


