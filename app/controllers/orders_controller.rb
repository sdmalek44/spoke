class OrdersController < ApplicationController
  helper_method :current_order
  before_action :require_specific_user
  before_action :require_registered_user, only: [:show, :create]

  def create
    flash[:notice] = "Successfully submitted your order totalling #{params[:grand_total]}"
    order = current_user.orders.create(status: 'pending')
    order.create_order_accessories(session[:cart])
    session[:cart] = nil

    redirect_to dashboard_path
  end

  def show
    @order_accessories = @order.order_accessories
  end

  def require_specific_user
    render file: "/public/404" unless admin_user? || (current_order == current_user.order)
  end

  def current_order
    @order = Order.find(params[:id]) if params[:id]
  end
end
