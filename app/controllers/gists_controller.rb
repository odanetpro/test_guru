# frozen_string_literal: true

class GistsController < ApplicationController
  def create
    @passing_test = PassingTest.find(params[:passing_test_id])

    result = GistQuestionService.new(@passing_test.current_question).call

    if result.success?
      Gist.create!(question_id: @passing_test.current_question.id, url: result[:url], user_id: @passing_test.user.id)
      flash_options = { notice: t('.success_html', gist_url: result[:url]) }
    else
      flash_options = { alert: t('.failure_html') }
    end

    redirect_to @passing_test, flash_options
  end
end
