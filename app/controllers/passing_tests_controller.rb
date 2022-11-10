class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result]

  def show; end

  def result
  end

  def update
    @passing_test.accept!(params[:answer_ids])
    render :show
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end
end
