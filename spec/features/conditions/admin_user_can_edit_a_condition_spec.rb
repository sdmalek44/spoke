require 'rails_helper'

describe "An admin user visits '/admin/conditions/:id/edit'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'they can update a weather condition by inputting valid information' do
    condition_1 = Condition.create(
      date: Date.new(2017, 12, 11),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 75.0,
      mean_visibility: 10.0,
      mean_wind_speed: 11.0,
      precipitation: 0.23)

    visit edit_admin_condition_path(condition_1)

    editted_date = Date.new(2014, 1, 1)
    editted_max_temp = 65.0
    editted_mean_temp = 60.0
    editted_min_temp = 55.0
    editted_mean_humidity = 60.0
    editted_mean_visibility = 15.0
    editted_mean_wind_speed = 20.0
    editted_precipitation = 0.45

    fill_in :condition_date, with: editted_date
    fill_in :condition_max_temperature, with: editted_max_temp
    fill_in :condition_mean_temperature, with: editted_mean_temp
    fill_in :condition_min_temperature, with: editted_min_temp
    fill_in :condition_mean_humidity, with: editted_mean_humidity
    fill_in :condition_mean_visibility, with: editted_mean_visibility
    fill_in :condition_mean_wind_speed, with: editted_mean_wind_speed
    fill_in :condition_precipitation, with: editted_precipitation
    click_on 'Update Condition'

    expect(current_path).to eq(condition_path(condition_1))
    expect(page).to have_content("Successfully updated weather condition for #{editted_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("Date: #{editted_date.strftime("%m/%d/%Y")}")
    expect(page).to have_content("Max Temperature: #{editted_max_temp}")
    expect(page).to have_content("Mean Temperature: #{editted_mean_temp}")
    expect(page).to have_content("Min Temperature: #{editted_min_temp}")
    expect(page).to have_content("Mean Humidity: #{editted_mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{editted_mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{editted_mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{editted_precipitation}")
  end
  it 'they cannot edit a condition without inputting valid information' do
    condition_1 = Condition.create(
      date: Date.new(2017, 12, 11),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 75.0,
      mean_visibility: 10.0,
      mean_wind_speed: 11.0,
      precipitation: 0.23)

    editted_date = Date.new(2014, 1, 1)
    editted_max_temp = 65.0
    editted_mean_temp = 60.0
    editted_min_temp = 55.0
    editted_mean_humidity = 60.0
    editted_mean_visibility = 15.0
    editted_mean_wind_speed = 20.0
    editted_precipitation = 0.45

    visit edit_admin_condition_path(condition_1)

    fill_in :condition_date, with: nil
    fill_in :condition_max_temperature, with: editted_max_temp
    fill_in :condition_mean_temperature, with: editted_mean_temp
    fill_in :condition_min_temperature, with: editted_min_temp
    fill_in :condition_mean_humidity, with: editted_mean_humidity
    fill_in :condition_mean_visibility, with: editted_mean_visibility
    fill_in :condition_mean_wind_speed, with: editted_mean_wind_speed
    fill_in :condition_precipitation, with: editted_precipitation
    click_on 'Update Condition'

    expect(current_path).to eq(edit_admin_condition_path(condition_1))
    expect(page).to have_content('Weather condition was not updated. Try again.')
  end
end
