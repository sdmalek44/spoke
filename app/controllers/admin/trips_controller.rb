class Admin::TripsController < ApplicationController
  def edit
    @trip = Trip.find(params[:id])
  end

  def new
    @trip = Trip.new
  end
end
