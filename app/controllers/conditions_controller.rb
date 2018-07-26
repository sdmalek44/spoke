class ConditionsController < ApplicationController
  before_action :require_registered_user, only: [:dashboard]
  before_action :require_admin_user, only: [:create, :update, :destroy]

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @conditions = ConditionCalculator.new
  end
end
