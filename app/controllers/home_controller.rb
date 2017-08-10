class HomeController < ApplicationController

  def welcome_page
    # set default selected sub category id and category id
    cookies[:selected_sub_category_id] = 10
    cookies[:selected_category_id] = 4

    redirect_to '/home' if user_signed_in?
  end

end
