class HomeController < ApplicationController

  def welcome_page
    redirect_to '/home' if user_signed_in?
  end

end
