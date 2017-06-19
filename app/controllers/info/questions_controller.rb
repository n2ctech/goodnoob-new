class Info::QuestionsController < ApplicationController
  before_action :set_question, only: [:show]

  def show
  end

  private

  def set_question
    @question = Info::Question.find(params[:id])
  end
end
