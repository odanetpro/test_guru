class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :auth_controller?

  private

  def authenticate_user!
    return if current_user

    redirect_to login_path, alert: 'Пожалуйста авторизуйтесь.'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def auth_controller?
    %w[users sessions].include?(params[:controller])
  end
end
