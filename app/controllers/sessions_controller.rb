class SessionsController < ApplicationController

  def new
    #saves the entered data if it needs to re-render the page
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
    redirect_to root_path
  end

  private 

  def auth
    request.env['omniauth.auth']
  end

  def login
    session[:user_id] = @user.id
    redirect_to @user
  end

end
