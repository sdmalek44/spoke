class Admin::UsersController < Admin::BaseController

  def dashboard
    if params[:status]
      @orders = Order.where(status: [params[:status], params[:status].titleize])
    else
      @orders = Order.all.includes(:order_accessories)
    end
  end

end
