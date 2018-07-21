class StationsController < ApplicationController
  def show
    @station = Station.find(params[:id])
  end
end
