class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]

  def index
    render html: @test.questions.map { |item| "<p>#{item.id}: #{item.body}</p>" }.join.html_safe
  end

  def show; end

  def new; end

  def create
    question = @test.questions.new(question_create_params)
    question.save

    question.persisted? ? render(plain: 'Вопрос создан!') : render(plain: question.errors.full_messages.to_s)
  end

  def destroy
    message = Question.find(params[:id]).destroy ? 'Вопрос удален!' : 'Произошла ошибка. Вопрос не удален!'
    render plain: message
  end

  private

  def question_create_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end
end
