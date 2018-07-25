class OrdersController < ApplicationController

  def create
    flash[:notice] = "Successfully submitted your order totalling #{params[:grand_total]}"
    redirect_to dashboard_path
  end
end
