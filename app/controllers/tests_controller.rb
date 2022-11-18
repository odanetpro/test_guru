class TestsController < ApplicationController
  before_action :set_test, only: %i[show start]

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
  end

  def start
    current_user.tests << @test

    redirect_to current_user.passing_test(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
end
