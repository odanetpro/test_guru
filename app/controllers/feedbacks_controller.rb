# frozen_string_literal: true

class FeedbacksController < ApplicationController
  def new; end

  def create
    if params[:message].present?
      FeedbacksMailer.user_feedback(email_params).deliver_now!
      redirect_to root_path, { notice: t('.success') }
    else
      flash.now[:alert] = t('.feedback_is_blank')
      render :new
    end
  end

  private

  def email_params
    { message: params[:message], user: current_user }
  end
end
