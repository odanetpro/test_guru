# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  before_action :set_test, only: %i[new create]
  before_action :set_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_resourse_not_found

  def show
    @test = @question.test
  end

  def new
    @question = @test.questions.build
  end

  def edit; end

  def create
    @question = @test.questions.build(question_params)

    if @question.save
      redirect_to [:admin, @test]
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question.test]
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to [:admin, @question.test]
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def set_test
    @test = Test.find(params[:test_id])
  end

  def set_question
    @question = Question.find(params[:id])
  end

  def rescue_with_resourse_not_found
    render html: '<p>Ресурс не найден!</p>'.html_safe, status: :not_found
  end
end
