class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit]

  def index
    @trips = Trip.all
  end

  def show
  end

  def new
    @trip = Trip.new
    @trip.locations.build 
  end

  def create
    @trip = Trip.new(trip_params)
    @trip.user = current_user

    if @trip.save
      redirect_to @trip
    else
      # @trip.locations.build
      render :new
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def trip_params
    params.require(:trip).permit(:name, :start_date, :end_date, :note, :user_id, trip_categories:[], location_attributes: [:id, :name, :_destroy])
  end
  
end
