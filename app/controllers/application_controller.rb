class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :require_login
  # skip_before_action :require_login, only: [:index]
  
  helper_method :current_user, :logged_in?, :authorized?, :nested?

  def current_user
    current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def authorized?(user)
    current_user == user
  end

  def nested?
    # !!(params[:user_id] || params[:id])
    !!params[:user_id]
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :image, :tagline, :profile)
  end


  def require_login
    redirect_back fallback_location: root_path, alert: "Login required."
  end

end
