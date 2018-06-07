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
    @trip = current_user.trips.build(trip_params)

    if @trip.save
      redirect_to @trip
    else
      @trip.locations.build
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
    params.require(:trip).permit(:name, :start_date, :end_date, :note, :user_id, category_ids: [], location_attributes: [:id, :name, :_destroy])
  end
  
end
