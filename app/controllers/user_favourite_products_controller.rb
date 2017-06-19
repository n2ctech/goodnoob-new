class UserFavouriteProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:create, :destroy]

  def create
    UserFavourite.add_to_favourites(user: current_user, element: @product)
    redirect_to @product
  end

  def destroy
    UserFavourite.remove_from_favourites(user: current_user, element: @product)
    if request.xhr?
      head 200
    else
      redirect_to @product
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
