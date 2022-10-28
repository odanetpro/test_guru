class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index create]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_resourse_not_found

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

  def rescue_with_resourse_not_found
    render html: '<p>Ресурс не найден!</p>'.html_safe, status: :not_found
  end
end
