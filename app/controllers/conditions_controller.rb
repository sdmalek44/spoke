class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @highest_number_of_rides_on_a_day_in_the_40s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(40)
    @highest_number_of_rides_on_a_day_in_the_50s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(50)
    @highest_number_of_rides_on_a_day_in_the_60s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(60)
    @highest_number_of_rides_on_a_day_in_the_70s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(70)
    @highest_number_of_rides_on_a_day_in_the_80s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(80)
    @highest_number_of_rides_on_a_day_in_the_90s = Condition.highest_number_of_rides_on_a_day_in_max_temperature_range(90)
  end
end
