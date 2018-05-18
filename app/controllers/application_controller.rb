class ApplicationController < ActionController::Base

  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :about)
  end

end
