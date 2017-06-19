class Info::TermsController < ApplicationController
  before_action :set_term, only: [:show]

  def show
  end

  private

  def set_term
    @term = Info::Term.find(params[:id])
  end
end
