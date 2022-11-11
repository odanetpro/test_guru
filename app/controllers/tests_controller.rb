class TestsController < ApplicationController
  before_action :set_test, only: %i[show start]

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
  end

  # TODO: fix after adding authorization
  def start
    @user = User.last
    @user.tests << @test

    redirect_to @user.passing_test(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end
end
