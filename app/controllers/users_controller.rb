class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
    @latest_limit = 5;
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    authorized_validation
  end

  def update
    authorized_validation
    @user.update(user_params)
    
    if @user.save
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def set_user
    @user ||= User.find_by(id: params[:id])
  end

  def authorized_validation(user = set_user)
    redirect_to user_path(@user), alert: "Not allowed." and return if !authorized?(user) 
  end
  
end
