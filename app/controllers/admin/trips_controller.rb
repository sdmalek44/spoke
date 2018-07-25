class Admin::TripsController < ApplicationController
  def edit
  end

  def new
    @trip = Trip.new
  end
end
