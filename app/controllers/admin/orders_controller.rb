class Admin::OrdersController < Admin::BaseController
  def update
    Order.update(order_params[:id], status: order_params[:status].to_i)
    redirect_to admin_dashboard_path
  end

  private

  def order_params
    params.permit(:id, :status)
  end
end
