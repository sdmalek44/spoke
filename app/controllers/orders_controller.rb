class OrdersController < ApplicationController
  before_action :require_registered_user, only: [:show, :create]

  def create
    flash[:notice] = "Successfully submitted your order totalling #{params[:grand_total]}"
    order = current_user.orders.create(status: 'pending')
    order.create_order_accessories(session[:cart])
    session[:cart] = nil

    redirect_to dashboard_path
  end

  def show
    @order = Order.find(params[:id])
    @order_accessories = @order.order_accessories
  end

  def require_specific_user
    render file: "/public/404" unless admin_user?
  end
end
