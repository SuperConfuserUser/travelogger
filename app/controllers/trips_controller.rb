class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit]

  def index
    @trips = Trip.all.reverse
  end

  def show
  end

  def new
    @trip = Trip.new
    @trip.locations.build 
  end

  def create
    @trip = current_user.trips.build(trip_params)

    if added_location? || !@trip.save
      @trip.locations.build if added_location?
      render :new
    else
      redirect_to @trip
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
    params.require(:trip).permit(:name, :start_date, :end_date, :note, :user_id, category_ids: [], locations_attributes: [:id, :name, :_destroy])
  end

  def added_location?
    params[:commit] == "+"
  end
  
end
