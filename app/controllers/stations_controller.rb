class StationsController < ApplicationController

  def show
    @station = Station.friendly.find(params[:id])
  end

  def index
    @stations = Station.all
  end
end
