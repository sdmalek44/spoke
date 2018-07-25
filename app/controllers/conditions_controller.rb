class ConditionsController < ApplicationController

  def index
    @conditions = Condition.all
  end

  def show
    @condition = Condition.find(params[:id])
  end

  def dashboard
    @highest_number_of_rides_on_a_day_in_the_40s = Trip.date_with_most_rides(40)[:rides]
    @highest_number_of_rides_on_a_day_in_the_50s = Trip.date_with_most_rides(50)[:rides]
    @highest_number_of_rides_on_a_day_in_the_60s = Trip.date_with_most_rides(60)[:rides]
    @highest_number_of_rides_on_a_day_in_the_70s = Trip.date_with_most_rides(70)[:rides]
    @highest_number_of_rides_on_a_day_in_the_80s = Trip.date_with_most_rides(80)[:rides]
    @highest_number_of_rides_on_a_day_in_the_90s = Trip.date_with_most_rides(90)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_40s = Trip.date_with_least_rides(40)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_50s = Trip.date_with_least_rides(50)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_60s = Trip.date_with_least_rides(60)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_70s = Trip.date_with_least_rides(70)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_80s = Trip.date_with_least_rides(80)[:rides]
    @lowest_number_of_rides_on_a_day_in_the_90s = Trip.date_with_least_rides(90)[:rides]
  end
end
