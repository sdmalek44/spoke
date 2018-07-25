class Admin::TripsController < ApplicationController
  def new
    @trip = Trip.new
  end

  def edit
    @trip = Trip.find(params[:id])
  end
end
