class StationsController < ApplicationController

  def show
    @station = Station.friendly.find(params[:id])
  end

  def index
    @stations = Station.all
  end

  def dashboard
    @stations = Station.all
    @stations_count = @stations.total_count
    @avg_bikes = @stations.average_bikes_per_station
    @station_most_bikes = @stations.station_with_most_bikes
    @station_least_bikes = @stations.station_with_least_bikes
  end
end
