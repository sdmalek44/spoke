class StationsController < ApplicationController
  before_action :require_registered_user, only: [:dashboard]

  def show
    @station = Station.friendly.find(params[:id])
    unless @station.trips.empty?
      @most_popular_destination = @station.frequent_destination_station
      @most_popular_origination = @station.frequent_origination_station
      @date_with_most_trips = @station.date_with_most_trips.strftime('%m/%d/%Y')
      @zip_code_with_most_trips = @station.zip_code_with_most_trips
      @bike_id_with_most_trips = @station.bike_id_with_most_trips
    end
  end

  def index
    @stations = Station.all
  end

  def edit
  end

  def destroy
    station = Station.find_by(slug: params[:id])
    station.destroy
    flash[:notice] = "You have successfully deleted #{station.name}"
    redirect_to stations_path
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
