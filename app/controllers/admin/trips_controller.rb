class Admin::TripsController < Admin::BaseController
  def new
    @trip = Trip.new
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      flash[:notice] = 'Successfully created trip'
      redirect_to trip_path(@trip)
    else
      flash[:notice] = 'Trip not created. Try again.'
      redirect_to new_admin_trip_path
    end
  end

  def edit
    @trip = Trip.find(params[:id])
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

  def destroy
    trip = Trip.find(params[:id])
    flash[:notice] = "Successfully deleted trip ##{trip.id}."
    trip.destroy
    redirect_to trips_path
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
