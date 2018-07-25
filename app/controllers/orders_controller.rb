class OrdersController < ApplicationController

  def create
    flash[:notice] = "Successfully submitted your order totalling #{params[:grand_total]}"
    order = current_user.orders.create(status: 'pending')
    order.create_order_accessories(session[:cart])
    session[:cart] = nil
    
    redirect_to dashboard_path
  end
end
