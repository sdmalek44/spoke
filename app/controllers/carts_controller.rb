class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    session[:cart] = @cart.add_accessory(accessory.id)
    quantity = @cart.count_of(accessory.id)

    flash[:notice] = "You now have #{pluralize(quantity, accessory.title)} in your cart."
    redirect_to bike_shop_path
  end

  def show
    @cart_accessories = @cart.make_accessories
  end
end
