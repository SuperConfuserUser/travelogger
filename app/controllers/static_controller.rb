class StaticController < ApplicationController
  def index
    redirect_to trips_path if logged_in?
    render :layout => "cover_page"
  end
end
