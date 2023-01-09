# frozen_string_literal: true

class FeedbacksMailer < ApplicationMailer
  def user_feedback(email_params)
    @message = email_params[:message]
    @user = email_params[:user]

    mail to: admin_emails
  end

  private

  def admin_emails
    User.admin_emails
  end
end
