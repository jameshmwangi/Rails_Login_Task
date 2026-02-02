class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :login_required

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def login_required
    unless logged_in?
      redirect_to new_session_path, alert: "Please login first"
    end
  end
end
