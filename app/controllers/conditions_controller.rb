class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @highest_number_of_rides_on_a_day_in_the_30s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(30)
    @highest_number_of_rides_on_a_day_in_the_40s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(40)
    @highest_number_of_rides_on_a_day_in_the_50s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(50)
    @highest_number_of_rides_on_a_day_in_the_60s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(60)
    @highest_number_of_rides_on_a_day_in_the_70s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(70)
    @highest_number_of_rides_on_a_day_in_the_80s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(80)
    @highest_number_of_rides_on_a_day_in_the_90s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(90)
    @lowest_number_of_rides_on_a_day_in_the_30s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(30)
    @lowest_number_of_rides_on_a_day_in_the_40s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(40)
    @lowest_number_of_rides_on_a_day_in_the_50s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(50)
    @lowest_number_of_rides_on_a_day_in_the_60s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(60)
    @lowest_number_of_rides_on_a_day_in_the_70s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(70)
    @lowest_number_of_rides_on_a_day_in_the_80s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(80)
    @lowest_number_of_rides_on_a_day_in_the_90s = Condition.lowest_number_of_rides_on_a_day_in_max_temperature_range(90)
    @average_number_of_rides_on_a_day_in_the_30s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(30)
    @average_number_of_rides_on_a_day_in_the_40s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(40)
    @average_number_of_rides_on_a_day_in_the_50s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(50)
    @average_number_of_rides_on_a_day_in_the_60s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(60)
    @average_number_of_rides_on_a_day_in_the_70s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(70)
    @average_number_of_rides_on_a_day_in_the_80s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(80)
    @average_number_of_rides_on_a_day_in_the_90s = Condition.average_number_of_rides_on_a_day_in_max_temperature_range(90)

    @highest_number_of_rides_on_a_day_with_0_0_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @highest_number_of_rides_on_a_day_with_0_5_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @highest_number_of_rides_on_a_day_with_1_0_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @highest_number_of_rides_on_a_day_with_1_5_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @highest_number_of_rides_on_a_day_with_2_0_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @highest_number_of_rides_on_a_day_with_2_5_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @highest_number_of_rides_on_a_day_with_3_0_inches = Condition.highest_number_of_rides_on_a_day_in_precipitation_range(3.0)
    @lowest_number_of_rides_on_a_day_with_0_0_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @lowest_number_of_rides_on_a_day_with_0_5_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @lowest_number_of_rides_on_a_day_with_1_0_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @lowest_number_of_rides_on_a_day_with_1_5_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @lowest_number_of_rides_on_a_day_with_2_0_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @lowest_number_of_rides_on_a_day_with_2_5_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @lowest_number_of_rides_on_a_day_with_3_0_inches = Condition.lowest_number_of_rides_on_a_day_in_precipitation_range(3.0)
    @average_number_of_rides_on_a_day_with_0_0_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(0.0)
    @average_number_of_rides_on_a_day_with_0_5_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(0.5)
    @average_number_of_rides_on_a_day_with_1_0_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(1.0)
    @average_number_of_rides_on_a_day_with_1_5_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(1.5)
    @average_number_of_rides_on_a_day_with_2_0_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(2.0)
    @average_number_of_rides_on_a_day_with_2_5_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(2.5)
    @average_number_of_rides_on_a_day_with_3_0_inches = Condition.average_number_of_rides_on_a_day_in_precipitation_range(3.0)
  end
end
