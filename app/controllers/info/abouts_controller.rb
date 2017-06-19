class Info::AboutsController < ApplicationController
  before_action :set_about, only: [:show]

  def show
  end

  private

  def set_about
    @about = Info::About.find(params[:id])
  end
end
