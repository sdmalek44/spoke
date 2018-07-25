class Admin::StationsController < ApplicationController
  def new
    @station = Station.new
  end

  def edit
    @station = Station.find_by(slug: params[:id])
  end
end
