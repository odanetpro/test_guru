class QuestionsController < ApplicationController
  def index
    render plain: Question.where(test_id: params[:test_id]).map { |item| item.body }.join("\n")
  end

  def show; end

  def new; end

  def create
    question = Test.find(params[:test_id]).questions.new(question_create_params)
    question.save

    question.persisted? ? render(plain: 'Вопрос создан!') : render(plain: question.errors.full_messages.to_s)
  end

  private

  def question_create_params
    params.require(:question).permit(:body)
  end
end
