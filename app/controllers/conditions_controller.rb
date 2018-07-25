class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def destroy
    condition = Condition.find(params[:id])
    condition.destroy
    flash[:notice] = "Successfully deleted weather condition for #{condition.date.strftime('%m/%d/%Y')}"
    redirect_to conditions_path
  end
end
