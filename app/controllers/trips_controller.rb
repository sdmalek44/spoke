class TripsController < ApplicationController
  before_action :require_registered_user, only: [:dashboard]

  def index
    @trips = Trip.search(params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
  end

  def create
    trip = Trip.new(trip_params)
    if trip.save
      flash[:notice] = 'Successfully created trip'
      redirect_to trip_path(trip)
    else
      flash[:notice] = 'Trip not created. Try again.'
      redirect_to new_admin_trip_path
    end
  end

  def destroy
    trip = Trip.find(params[:id])
    trip.destroy
    flash[:notice] = "Successfully deleted trip."
    redirect_to trips_path
  end

  def update
    trip = Trip.find(params[:id])
    if trip.update(trip_params)
      flash[:notice] = "Successfully updated trip"
      redirect_to trip_path(trip)
    else
      flash[:notice] = "Trip was not updated. Try again."
      redirect_to edit_admin_trip_path(trip)
    end
  end

  def dashboard
    @average_ride_duration = Trip.average_ride_duration
    @longest_ride_duration = Trip.longest_ride_duration
    @shortest_ride_duration = Trip.shortest_ride_duration
    @most_frequent_start_station = Trip.most_frequent_start_station
    @most_frequent_end_station = Trip.most_frequent_end_station
    @rides_per_month = Trip.rides_per_month
    @rides_per_year = Trip.rides_per_year
    @most_ridden_bike = Trip.most_ridden_bike
    @least_ridden_bike = Trip.least_ridden_bike
    @subscription_type_count = Trip.subscription_type_count
    @total_trips = Trip.all.count
    @date_with_most_rides = Trip.date_with_most_rides
    @date_with_least_rides = Trip.date_with_least_rides
  end

  private

  def trip_params
    params.require(:trip).permit(
      :duration,
      :start_date,
      :end_date,
      :start_station_id,
      :end_station_id,
      :bike_id,
      :zip_code,
      :subscription_type)
  end
end
