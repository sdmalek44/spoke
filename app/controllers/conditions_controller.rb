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

  def update
    condition = Condition.find(params[:id])
    if condition.update(condition_params)
      flash[:notice] = "Successfully updated weather condition for #{condition.date.strftime('%m/%d/%Y')}"
      redirect_to condition_path(condition)
    else
      flash[:notice] = "Weather condition was not updated. Try again."
      redirect_to edit_admin_condition_path(condition)
    end
  end

  def destroy
    condition = Condition.find(params[:id])
    condition.destroy
    flash[:notice] = "Successfully deleted weather condition for #{condition.date.strftime('%m/%d/%Y')}"
    redirect_to conditions_path
  end

  def dashboard
    @conditions = ConditionCalculator.new

    @highest_number_of_rides_on_a_day_in_the_30s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(30)
    @highest_number_of_rides_on_a_day_in_the_40s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(40)
    @highest_number_of_rides_on_a_day_in_the_50s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(50)
    @highest_number_of_rides_on_a_day_in_the_60s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(60)
    @highest_number_of_rides_on_a_day_in_the_70s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(70)
    @highest_number_of_rides_on_a_day_in_the_80s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(80)
    @highest_number_of_rides_on_a_day_in_the_90s = @conditions.highest_number_of_rides_on_a_day_in_max_temperature_range(90)
    @lowest_number_of_rides_on_a_day_in_the_30s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(30)
    @lowest_number_of_rides_on_a_day_in_the_40s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(40)
    @lowest_number_of_rides_on_a_day_in_the_50s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(50)
    @lowest_number_of_rides_on_a_day_in_the_60s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(60)
    @lowest_number_of_rides_on_a_day_in_the_70s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(70)
    @lowest_number_of_rides_on_a_day_in_the_80s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(80)
    @lowest_number_of_rides_on_a_day_in_the_90s = @conditions.lowest_number_of_rides_on_a_day_in_max_temperature_range(90)
    @average_number_of_rides_on_a_day_in_the_30s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(30)
    @average_number_of_rides_on_a_day_in_the_40s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(40)
    @average_number_of_rides_on_a_day_in_the_50s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(50)
    @average_number_of_rides_on_a_day_in_the_60s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(60)
    @average_number_of_rides_on_a_day_in_the_70s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(70)
    @average_number_of_rides_on_a_day_in_the_80s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(80)
    @average_number_of_rides_on_a_day_in_the_90s = @conditions.average_number_of_rides_on_a_day_in_max_temperature_range(90)
    #
    @highest_number_of_rides_on_a_day_with_0_0_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @highest_number_of_rides_on_a_day_with_0_5_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @highest_number_of_rides_on_a_day_with_1_0_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @highest_number_of_rides_on_a_day_with_1_5_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @highest_number_of_rides_on_a_day_with_2_0_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @highest_number_of_rides_on_a_day_with_2_5_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @highest_number_of_rides_on_a_day_with_3_0_inches = @conditions.highest_number_of_rides_on_a_day_in_precipitation_range(3.0)
    @lowest_number_of_rides_on_a_day_with_0_0_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @lowest_number_of_rides_on_a_day_with_0_5_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @lowest_number_of_rides_on_a_day_with_1_0_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @lowest_number_of_rides_on_a_day_with_1_5_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @lowest_number_of_rides_on_a_day_with_2_0_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @lowest_number_of_rides_on_a_day_with_2_5_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @lowest_number_of_rides_on_a_day_with_3_0_inches = @conditions.lowest_number_of_rides_on_a_day_in_precipitation_range(3.0)
    @average_number_of_rides_on_a_day_with_0_0_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @average_number_of_rides_on_a_day_with_0_5_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @average_number_of_rides_on_a_day_with_1_0_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @average_number_of_rides_on_a_day_with_1_5_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @average_number_of_rides_on_a_day_with_2_0_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @average_number_of_rides_on_a_day_with_2_5_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @average_number_of_rides_on_a_day_with_3_0_inches = @conditions.average_number_of_rides_on_a_day_in_precipitation_range(3.0)
    #
    @highest_number_of_rides_on_a_day_with_0_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(0)
    @highest_number_of_rides_on_a_day_with_4_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(4)
    @highest_number_of_rides_on_a_day_with_8_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(8)
    @highest_number_of_rides_on_a_day_with_12_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(12)
    @highest_number_of_rides_on_a_day_with_16_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(16)
    @highest_number_of_rides_on_a_day_with_20_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(20)
    @highest_number_of_rides_on_a_day_with_24_mph_wind = @conditions.highest_number_of_rides_on_a_day_in_mean_wind_speed_range(24)
    @lowest_number_of_rides_on_a_day_with_0_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(0)
    @lowest_number_of_rides_on_a_day_with_4_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(4)
    @lowest_number_of_rides_on_a_day_with_8_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(8)
    @lowest_number_of_rides_on_a_day_with_12_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(12)
    @lowest_number_of_rides_on_a_day_with_16_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(16)
    @lowest_number_of_rides_on_a_day_with_20_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(20)
    @lowest_number_of_rides_on_a_day_with_24_mph_wind = @conditions.lowest_number_of_rides_on_a_day_in_mean_wind_speed_range(24)
    @average_number_of_rides_on_a_day_with_0_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(0)
    @average_number_of_rides_on_a_day_with_4_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(4)
    @average_number_of_rides_on_a_day_with_8_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(8)
    @average_number_of_rides_on_a_day_with_12_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(12)
    @average_number_of_rides_on_a_day_with_16_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(16)
    @average_number_of_rides_on_a_day_with_20_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(20)
    @average_number_of_rides_on_a_day_with_24_mph_wind = @conditions.average_number_of_rides_on_a_day_in_mean_wind_speed_range(24)
    #
    @highest_number_of_rides_on_a_day_with_0_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(0)
    @highest_number_of_rides_on_a_day_with_4_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(4)
    @highest_number_of_rides_on_a_day_with_8_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(8)
    @highest_number_of_rides_on_a_day_with_12_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(12)
    @highest_number_of_rides_on_a_day_with_16_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(16)
    @highest_number_of_rides_on_a_day_with_20_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(20)
    @highest_number_of_rides_on_a_day_with_24_mile_visibility = @conditions.highest_number_of_rides_on_a_day_in_mean_visibility_range(24)
    @lowest_number_of_rides_on_a_day_with_0_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(0)
    @lowest_number_of_rides_on_a_day_with_4_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(4)
    @lowest_number_of_rides_on_a_day_with_8_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(8)
    @lowest_number_of_rides_on_a_day_with_12_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(12)
    @lowest_number_of_rides_on_a_day_with_16_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(16)
    @lowest_number_of_rides_on_a_day_with_20_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(20)
    @lowest_number_of_rides_on_a_day_with_24_mile_visibility = @conditions.lowest_number_of_rides_on_a_day_in_mean_visibility_range(24)
    @average_number_of_rides_on_a_day_with_0_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(0)
    @average_number_of_rides_on_a_day_with_4_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(4)
    @average_number_of_rides_on_a_day_with_8_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(8)
    @average_number_of_rides_on_a_day_with_12_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(12)
    @average_number_of_rides_on_a_day_with_16_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(16)
    @average_number_of_rides_on_a_day_with_20_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(20)
    @average_number_of_rides_on_a_day_with_24_mile_visibility = @conditions.average_number_of_rides_on_a_day_in_mean_visibility_range(24)
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
