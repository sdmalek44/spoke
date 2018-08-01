class StationsController < ApplicationController
  before_action :require_registered_user, only: [:dashboard]

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
    @newest_station = @stations.newest_station
    @oldest_station = @stations.oldest_station
  end
end
