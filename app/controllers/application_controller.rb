class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user,:logged_in?, :format_time,:has_read?


  def current_user
      current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def format_time time
    time.strftime("%Y-%m-%d %H:%M")
  end

  def has_read? message
    message.notification.read
  end
end
