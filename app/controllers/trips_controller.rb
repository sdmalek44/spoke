class TripsController < ApplicationController

  def index
    @trips = Trip.search(params[:page])
  end

  def show
    @trip = Trip.find(params[:id])
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
end
