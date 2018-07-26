class Admin::UsersController < Admin::BaseController

  def dashboard
    @orders = Order.all.includes(:order_accessories)
  end
end
