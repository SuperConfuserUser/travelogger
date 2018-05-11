class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # @user = User.find_or_create_by_omniauth(auth)

    # if @user
    #   session[:user_id] = @user.id
    #   redirect_to @user
    # else
    #   redirect_to new_user_path, alert: "Facebook didn't work."
    # end
    byebug

    @user = User.find_by(params[:user][:username]) || User.new

    
    if @user && @user.authenticate(params[:user][:password]) 
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to login_path, alert: "no workies"
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
