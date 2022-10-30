class QuestionsController < ApplicationController
  before_action :find_test, only: %i[index new create]
  before_action :find_question, only: %i[show destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_resourse_not_found

  def index
    render html: @test.questions.map { |item| "<p>#{item.id}: #{item.body}</p>" }.join.html_safe
  end

  def show; end

  def new; end

  def create
    @question = @test.questions.build(question_params)
    
    if @question.save
       redirect_to @question
    else
      render :new
    end
  end

  def destroy
    @question.destroy
    render plain: 'Вопрос удален!'
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def rescue_with_resourse_not_found
    render html: '<p>Ресурс не найден!</p>'.html_safe, status: :not_found
  end
end
