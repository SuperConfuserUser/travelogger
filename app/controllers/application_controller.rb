class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  
  helper_method :current_user, :logged_in?

  def current_user
    current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :about)
  end


  def require_login
    # flash[:alert] = 'Login required.'
    redirect_back fallback_location: root_path, alert: "Login required."
  end

end
