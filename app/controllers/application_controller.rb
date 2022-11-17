class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  before_action :authenticate_user!, unless: :auth_controller?

  private

  def authenticate_user!
    return if current_user

    cookies[:target_path] = request.fullpath
    redirect_to login_path, alert: 'Пожалуйста авторизуйтесь.'
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def auth_controller?
    %w[users sessions].include?(params[:controller])
  end

  def target_path
    cookies[:target_path] || root_path
  end
end
