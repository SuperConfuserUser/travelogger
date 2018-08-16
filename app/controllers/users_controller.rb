class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :user_url_validation, only: [:show, :edit]
  before_action :authorized_validation, only: [:edit, :update]

  def index
    @users = User.all
  end

  def show
    @latest_limit = 5;
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @user }
    end
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
  end

  def update 
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

  def user_id
    params[:id] || current_user.id 
  end

  def user_url_validation
    if user_id
      set_user
      redirect_to users_path, alert: "User not found." and return if !@user
    end
  end

  def authorized_validation(user = set_user)
    redirect_to user_path(@user), alert: "Not allowed." and return if !authorized?(user) 
  end
end
