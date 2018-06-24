class SessionsController < ApplicationController

  def new
    @user = User.new
  end

     
  def create
    if auth 
      @user = User.find_or_create_by_omniauth(auth)
      login
    else
     @user = User.login(user_params)

      if @user.errors.none? && @user.valid?
        login
      else
        render :new
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path, alert: "Logged out."
  end

  private 

  def auth
    request.env['omniauth.auth']
  end

  def login
    session[:user_id] = @user.id
    redirect_to root_path
  end

end
