class SessionsController < ApplicationController

  def new
  end

  def create
    
    @user = User.find_or_create_by_omniauth(auth)

    if @user
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to new_user_path, alert: "Facebook didn't work."
    end
  end

  def destroy
  end

  private 

  def auth
    request.env['omniauth.auth']
  end

end
