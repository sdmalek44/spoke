class StationsController < ApplicationController

  def show
    @station = Station.find(params[:id])
  end

  def index
    @stations = Station.all
  end
end
