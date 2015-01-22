class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def current_user
    User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_signin
    if !logged_in?
      redirect_to sign_in_path
    end
  end

  protect_from_forgery with: :exception
end
