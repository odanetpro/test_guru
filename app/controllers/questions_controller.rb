class QuestionsController < ApplicationController
  def index
    render plain: Question.where(test_id: params[:test_id]).map { |item| item.body }.join("\n")
  end

  def show; end
end
