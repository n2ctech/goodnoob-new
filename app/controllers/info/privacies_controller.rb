class Info::PrivaciesController < ApplicationController
  before_action :set_privacy, only: [:show]

  def show
  end

  private

  def set_privacy
    @privacy = Info::Privacy.find(params[:id])
  end
end
