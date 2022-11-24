# frozen_string_literal: true

class TestsController < ApplicationController
  def index
    @tests = Test.all
  end

  def start
    @test = Test.find(params[:id])

    current_user.tests << @test
    redirect_to current_user.passing_test(@test)
  end
end
