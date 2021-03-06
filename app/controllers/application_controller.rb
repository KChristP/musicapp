class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
  end

  def login!(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def logout
    current_user.reset_session_token
  end

  def logged_in?(user)
    user == current_user
  end
end
