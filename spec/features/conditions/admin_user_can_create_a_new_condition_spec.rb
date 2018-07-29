require 'rails_helper'

describe "An admin user visits '/admin/conditions/new'" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'they can create a new condition by inputting valid information' do
    date = Date.new(2014, 1, 1)
    max_temp = 75.0
    mean_temp = 70.0
    min_temp = 65.0
    mean_humidity = 60.0
    mean_visibility = 10.0
    mean_wind_speed = 20.0
    precipitation = 0.23

    visit new_admin_condition_path

    fill_in :condition_date, with: date
    fill_in :condition_max_temperature, with: max_temp
    fill_in :condition_mean_temperature, with: mean_temp
    fill_in :condition_min_temperature, with: min_temp
    fill_in :condition_mean_humidity, with: mean_humidity
    fill_in :condition_mean_visibility, with: mean_visibility
    fill_in :condition_mean_wind_speed, with: mean_wind_speed
    fill_in :condition_precipitation, with: precipitation
    click_on 'Create Condition'

    expect(current_path).to eq(condition_path(Condition.last))
    expect(page).to have_content("Successfully created weather condition for #{date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("Weather Conditions for #{date.strftime("%m/%d/%Y")}")
    expect(page).to have_content("Max Temperature: #{max_temp}")
    expect(page).to have_content("Mean Temperature: #{mean_temp}")
    expect(page).to have_content("Min Temperature: #{min_temp}")
    expect(page).to have_content("Mean Humidity: #{mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{precipitation}")
  end
  it 'they cannot create a new condition without inputting valid information' do
    date = Date.new(2014, 1, 1)
    max_temp = 75.0
    mean_temp = 70.0
    min_temp = 65.0
    mean_humidity = 60.0
    mean_visibility = 10.0
    mean_wind_speed = 20.0
    precipitation = 0.23

    visit new_admin_condition_path

    fill_in :condition_date, with: nil
    fill_in :condition_max_temperature, with: max_temp
    fill_in :condition_mean_temperature, with: mean_temp
    fill_in :condition_min_temperature, with: min_temp
    fill_in :condition_mean_humidity, with: mean_humidity
    fill_in :condition_mean_visibility, with: mean_visibility
    fill_in :condition_mean_wind_speed, with: mean_wind_speed
    fill_in :condition_precipitation, with: precipitation
    click_on 'Create Condition'

    expect(current_path).to eq(new_admin_condition_path)
    expect(page).to have_content('Weather condition not created. Try again.')
  end
end
