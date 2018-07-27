class OrdersController < ApplicationController
  helper_method :current_order, :current_order_user
  before_action :require_specific_user, only: [:show]
  before_action :require_registered_user, only: [:create]

  def create
    flash[:notice] = "Successfully submitted your order totalling #{params[:grand_total]}"
    order = current_user.orders.create(status: 'pending')
    order.create_order_accessories(session[:cart])
    session[:cart] = nil

    redirect_to dashboard_path
  end

  def show
    @order = Order.find(params[:id])
    @order_accessories = @order.order_accessories if @order
  end

  def require_specific_user
    render file: "/public/404" unless admin_user? || (current_order_user == current_user)
  end

  def current_order_user
    @order = Order.find(params[:id]) if params[:id]
    @order.user if @order
  end
end
