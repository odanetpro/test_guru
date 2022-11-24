# frozen_string_literal: true

class Admin::TestsController < Admin::BaseController
  def index
    @tests = Test.all
  end

  def show
    @test = Test.find(params[:id])
    @questions = @test.questions
  end
end
