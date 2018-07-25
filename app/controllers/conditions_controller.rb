class ConditionsController < ApplicationController
  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def create
    condition = Condition.new(condition_params)
    if condition.save
      flash[:notice] = "Successfully created weather condition for #{condition.date.strftime('%m/%m/%Y')}"
      redirect_to condition_path(condition)
    else
      flash[:notice] = "Weather condition not created. Try again."
      redirect_to new_admin_condition_path
    end
  end

  def destroy
    condition = Condition.find(params[:id])
    condition.destroy
    flash[:notice] = "Successfully deleted weather condition for #{condition.date.strftime('%m/%d/%Y')}"
    redirect_to conditions_path
  end

  private

  def condition_params
    params.require(:condition).permit(
      :date,
      :max_temperature,
      :mean_temperature,
      :min_temperature,
      :mean_humidity,
      :mean_visibility,
      :mean_wind_speed,
      :precipitation)
  end
end
