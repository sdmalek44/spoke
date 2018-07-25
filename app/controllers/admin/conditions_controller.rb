class Admin::ConditionsController < ApplicationController
  def new
    @condition = Condition.new
  end
  def edit
    @condition = Condition.find(params[:id])
  end
end
