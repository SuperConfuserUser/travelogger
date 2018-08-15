class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_action :user_url_validation, only: [:new, :show, :edit]
  before_action :trip_url_validation, only: [:show, :edit]
  
  # "fat models, skinny controllers"

  def index
    set_user
    @categories = Category.all
    @trips = Trip.filtered_by(user: params[:user_id], category: params[:category])
    respond_to do |format|
      format.html { render :index }
      format.json { render json: @trips }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @trip }
    end
  end

  def new
    @trip = Trip.new(user_id: user_id, start_date: Date.today)
    @trip.locations.build
  end

  def create
    @trip = Trip.new(trip_params)

    if added_location? || !@trip.save
      @trip.locations.build if added_location?
      render :new
    else
      render json: @trip, status: 201
    end
  end

  def edit
    authorized_validation
  end
    
  def update
    authorized_validation(@trip.user)
    @trip.update(trip_params)

    if added_location? || !@trip.save
      @trip.locations.build if added_location?
      render :edit 
    else
      redirect_to user_trip_path(@trip.user, @trip)
    end
  end

  def destroy
    authorized_validation(@trip.user)

    @trip.destroy
    redirect_to user_trips_path(current_user), alert: "Trip deleted."
  end

  private

  def set_trip
    @trip ||= Trip.find_by(id: params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :note, :user_id, category_ids: [], trip_category_attributes: [:category_id, :description, :_destroy],  locations_attributes: [:id, :name, :_destroy])
  end

  def added_location?
    params[:commit] == "+"
  end

  def set_user
    @user ||= User.find_by(id: params[:user_id])
  end

  def user_id
    params[:user_id] || current_user.id 
  end

  def user_url_validation
    if nested?
      set_user
      redirect_to trips_path, alert: "User not found." and return if !@user
    end
  end

  def trip_url_validation
    redirect_to user_trips_path(@user), alert: "Trip not found." and return if @trip.nil?
  end

  def authorized_validation(user = set_user)
    redirect_to user_trip_path(@user, @trip), alert: "Not allowed." and return if !authorized?(user) 
  end

end
