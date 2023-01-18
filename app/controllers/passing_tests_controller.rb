# frozen_string_literal: true

class PassingTestsController < ApplicationController
  before_action :set_passing_test, only: %i[show update result]

  def show; end

  def result
    return if @passing_test.passed? || !@passing_test.sucsessful?

    @passing_test.set_passed!

    @badges = []
    Badge.all.each do |badge|
      @badges << badge if badge.award?(user: @passing_test.user, test: @passing_test.test) &&
                          Award.create!(user_id: current_user.id, badge_id: badge.id)
    end
  end

  def update
    @passing_test.accept!(params[:answer_ids])

    if @passing_test.complited?
      redirect_to result_passing_test_path(@passing_test)
    else
      render :show
    end
  end

  private

  def set_passing_test
    @passing_test = PassingTest.find(params[:id])
  end
end
