class CartsController < ApplicationController
  def create
    accessory = Accessory.find(params[:accessory_id])

    @cart.add_accessory(accessory.id.to_s)
    
  end
end
