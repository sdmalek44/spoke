class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    session[:cart] = @cart.add_accessory(accessory.id)
    quantity = @cart.count_of(accessory.id)

    flash[:notice] = "You now have #{pluralize(quantity, accessory.title)} in your cart."
    redirect_to bike_shop_path
  end

  def destroy
    accessory = Accessory.find(params[:accessory_id])

    session[:cart] = @cart.remove_accessory(accessory.id)

    flash[:notice] = "Successfully removed #{accessory.title} from your cart."

    redirect_to cart_path(removed_id: accessory.id)
  end

  def show
    @removed_accessory = Accessory.find(params[:removed_id]) if params[:removed_id]
    @cart_accessories = @cart.make_accessories
  end
end
