class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    accessory = Accessory.find(params[:accessory_id])

    session[:cart] = @cart.add_accessory(accessory.id)
    quantity = @cart.count_of(accessory.id)

    flash[:notice] = "You now have #{pluralize(quantity, accessory.title)} in your cart."
    if params[:in_cart]
      redirect_to cart_path
    elsif params[:on_show]
      redirect_to accessory_path(accessory)
    else
      redirect_to bike_shop_path
    end
  end

  def destroy
    accessory = Accessory.find(params[:accessory_id])
    if params[:remove] == "true"
      session[:cart] = @cart.remove_accessory(accessory.id)
      flash[:notice] = "Successfully removed #{accessory.title} from your cart."
      redirect_to cart_path(removed_id: accessory.id)
    else
      session[:cart] = @cart.decrease_quantity(accessory.id)
      redirect_to cart_path
    end
  end

  def show
    @removed_accessory = Accessory.find(params[:removed_id]) if params[:removed_id]
    @cart_accessories = @cart.make_accessories
  end
end
