class TripsController < ApplicationController

  def index
    @trips = Trip.search(params[:term], params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end
end
