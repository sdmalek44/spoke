class Admin::UsersController < Admin::BaseController

  def dashboard
    @orders = Order.all.includes(:order_accessories)
    @status_totals = @orders.orders_per_status if @orders
    if params[:status] == 'all'
      @orders
    elsif params[:status]
      @orders = Order.where(status: params[:status].to_i)
    end
  end
end
