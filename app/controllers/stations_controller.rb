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

  def create
    station = Station.new(station_params)
    if station.save
      flash[:notice] = "Successfully created #{station.name}"
      redirect_to station_path(station)
    else
      flash[:notice] = "Station not created, try again"
      redirect_to new_admin_station_path
    end
  end

  def update
    station = Station.find_by(slug: params[:id])
    if station.update(station_params)
      flash[:notice] = "Successfully updated #{station.name}"
      redirect_to station_path(station)
    else
      flash[:notice] = "Station was not updated. Try again."
      redirect_to edit_admin_station_path(station)
    end
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

  private

  def station_params
    params.require(:station).permit(:name, :city, :dock_count, :installation_date)
  end
end
