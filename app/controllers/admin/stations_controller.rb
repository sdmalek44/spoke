class Admin::StationsController < Admin::BaseController
  def new
    @station = Station.new
  end

  def create
    @station = Station.new(station_params)
    if @station.save
      flash[:notice] = "Successfully created #{@station.name}"
      redirect_to station_path(@station)
    else
      flash[:notice] = "Station not created, try again"
      render :new
    end
  end

  def edit
    @station = Station.find_by(slug: params[:id])
  end

  def update
    @station = Station.find_by(slug: params[:id])
    if @station.update(station_params)
      @station.update(slug: params[:name])
      flash[:notice] = "Successfully updated #{@station.name}"
      redirect_to station_path(@station)
    else
      flash[:notice] = "Station was not updated. Try again."
      render :edit
    end
  end

  def destroy
    station = Station.find_by(slug: params[:id])
    station.destroy
    flash[:notice] = "You have successfully deleted #{station.name}"
    redirect_to stations_path
  end

  private

  def station_params
    params.require(:station).permit(:name, :city, :dock_count, :installation_date)
  end
end
