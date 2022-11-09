class TestsController < ApplicationController
  before_action :set_test, only: %i[show start]
  before_action :set_user, only: :start

  def index
    @tests = Test.all
  end

  def show
    @questions = @test.questions
  end

  def start
    redirect_to @user.passing_test(@test)
  end

  private

  def set_test
    @test = Test.find(params[:id])
  end

  def set_user
    # TODO: fix after adding authorization
    @user = User.last
  end
end
