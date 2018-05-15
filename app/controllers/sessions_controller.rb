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

    @user = User.find_by(email: params[:user][:email]) || User.new(username: params[:user][:username]) 

    @user = User.new.login(params[:user])
   
    if @user.valid? && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:alert] = "That login info didn't work."
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
