class SessionsController < ApplicationController

  def new
    @user = User.new
  end

     
  def create
     @user = User.login(user_params)

     if @user.errors.none? && @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private 

  def auth
    request.env['omniauth.auth']
  end

end
