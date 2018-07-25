class Admin::ConditionsController < ApplicationController
  def edit
    @condition = Condition.find(params[:id])
  end
end
