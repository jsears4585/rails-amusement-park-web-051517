class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :current_user
  before_action :requires_login, except: [:new, :create, :welcome]

  helper_method :current_user

  def logged_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def requires_login
    redirect_to '/' unless logged_in?
  end

end
