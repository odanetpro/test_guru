# frozen_string_literal: true

class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result]
  before_action :set_badges, only: :result

  def show; end

  def result; end

  def update
    @passing_test.accept!(params[:answer_ids])

    if @passing_test.complited?
      if @passing_test.sucsessful?
        @passing_test.set_passed!

        result = BadgesAwardService.new(@passing_test.user, @passing_test.test).call
        badges_ids = result.badges_ids if result.success?
      end

      redirect_to result_passing_test_path(@passing_test, badges: badges_ids)
    else
      render :show
    end
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end

  def set_badges
    @badges = Badge.find(params[:badges])
  rescue ActiveRecord::RecordNotFound
    # do nothing
  end
end
