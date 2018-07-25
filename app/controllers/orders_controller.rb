class OrdersController < ApplicationController

  def create
    binding.pry
    user = User.find(params[:user_id])
    Order.create(user_id: user.id)


  end
end
