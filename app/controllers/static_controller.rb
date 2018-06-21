class StaticController < ApplicationController  
  def index
    redirect_to trips_path if logged_in?
  end
end
