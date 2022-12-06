# frozen_string_literal: true

class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result gist]

  def show; end

  def result; end

  def update
    @passing_test.accept!(params[:answer_ids])

    if @passing_test.complited?
      redirect_to result_passing_test_path(@passing_test)
    else
      render :show
    end
  end

  def gist
    result = GistQuestionService.new(@passing_test.current_question).call
    
    flash_options = if result
                      { notice: t('.success', gist_url: result.html_url) }
                    else
                      { alert: t('.failure') }
                    end

    redirect_to @passing_test, flash_options
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end
end
