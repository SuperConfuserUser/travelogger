class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]

  # "fat models, skinny controllers"

  def index
    @categories = Category.all
    set_user

    @trips = Trip.filtered_by( order: params[:order], user: params[:user_id], category: params[:category])
  end

  def show
  end

  def new
    if !user_id
      redirect_to users_path, alert: "User not found."
    else
      @trip = Trip.new(user_id: user_id, start_date: Date.today)
      @trip.locations.build 
    end
  end

  def create
    @trip = Trip.new(trip_params)

    if added_location? || !@trip.save
      @trip.locations.build if added_location?
      render :new
    else
      redirect_to @trip
    end
  end

  def edit
    if user_id
      set_user
      if !set_user
        redirect_to trips_path, alert: "User not found."
      elsif @trip.nil?
        redirect_to user_trips_path(@user), alert: "Trip not found."
      end
      if set_user != current_user
        redirect_to :back, alert: "Not allowed."
      end
    end
  end
    
  def update
    @trip.update(trip_params)

    if @trip.save
      redirect_to @trip
    else
      render :edit
    end
  end

  def destroy
    if current_user == @trip.user
      @trip.destroy
      redirect_to user_trips_path(current_user), alert: "Trip deleted."
    else
      redirect_to trips_path(@trip), alert: "Not allowed."
    end
  end

  private

  def set_trip
    @trip = Trip.find_by(id: params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :note, :user_id, category_ids: [], categories_attributes: [:name], locations_attributes: [:id, :name, :_destroy])
  end

  def added_location?
    params[:commit] == "+"
  end

  def set_user
    @user = User.find_by(id: params[:user_id])
  end

  def user_id
    params[:user_id] || current_user.id 
  end

    #covers if route is nested or unnested. I wrote links so they should always be nested, but user can always go to the un-nested manually


end
