class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      #session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :email, :about)

end
