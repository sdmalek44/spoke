class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    @cart.add_accessory(accessory.id.to_s)
    session[:cart] = @cart.contents

    quantity = session[:cart][accessory.id.to_s]
    flash[:notice] = "You now have #{pluralize(quantity, accessory.title)} in your cart."
    redirect_to bike_shop_path
  end
end
