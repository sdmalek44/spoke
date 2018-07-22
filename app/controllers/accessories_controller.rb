class AccessoriesController < ApplicationController
  def show
    @accessory = Accessory.find(params[:id])
  end

  def index
    @accessories = Accessory.all 
  end
end
