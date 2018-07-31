class TripsController < ApplicationController
  before_action :require_registered_user, only: [:dashboard]

  def index
    @trips = Trip.search(params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def dashboard
    @ride_durations = Trip.duration_info
    @most_frequent_stations = Trip.station_info
    @rides_per_month = Trip.rides_per_month
    @rides_per_year = Trip.rides_per_year
    @bike_info = Trip.bike_info
    @subscription_types = Trip.subscription_type_info
    @ride_info = Trip.date_info
  end
end
