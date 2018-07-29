require 'rails_helper'

describe "A visitor visits '/conditions/:id'" do
  it 'they the attributes for the conditinon' do
    condition_1 = Condition.create(
      date: Date.new(2017, 12, 11),
      max_temperature: 75.0,
      mean_temperature: 65.0,
      min_temperature: 55.0,
      mean_humidity: 75.0,
      mean_visibility: 10.0,
      mean_wind_speed: 11.0,
      precipitation: 0.23)

    visit condition_path(condition_1)

    expect(page).to have_content(condition_1.date.strftime("%m/%d/%Y"))
    expect(page).to have_content("Max Temperature: #{condition_1.max_temperature}")
    expect(page).to have_content("Mean Temperature: #{condition_1.mean_temperature}")
    expect(page).to have_content("Min Temperature: #{condition_1.min_temperature}")
    expect(page).to have_content("Mean Humidity: #{condition_1.mean_humidity}")
    expect(page).to have_content("Mean Visibility: #{condition_1.mean_visibility}")
    expect(page).to have_content("Mean Wind Speed: #{condition_1.mean_wind_speed}")
    expect(page).to have_content("Precipitation: #{condition_1.precipitation}")
  end

  describe "an admin user visits '/conditions/:id'" do
    before :each do
      user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end
    it 'they can see the same information as a visitor' do
      condition = Condition.create(
        date: Date.new(2017, 12, 11),
        max_temperature: 75.0,
        mean_temperature: 65.0,
        min_temperature: 55.0,
        mean_humidity: 75.0,
        mean_visibility: 10.0,
        mean_wind_speed: 11.0,
        precipitation: 0.23)

      visit condition_path(condition)

      expect(page).to have_content(condition.date.strftime('%m/%d/%Y'))
      expect(page).to have_content("Max Temperature: #{condition.max_temperature}")
      expect(page).to have_content("Mean Temperature: #{condition.mean_temperature}")
      expect(page).to have_content("Min Temperature: #{condition.min_temperature}")
      expect(page).to have_content("Mean Humidity: #{condition.mean_humidity}")
      expect(page).to have_content("Mean Visibility: #{condition.mean_visibility}")
      expect(page).to have_content("Mean Wind Speed: #{condition.mean_wind_speed}")
      expect(page).to have_content("Precipitation: #{condition.precipitation}")
    end
    it 'they see a button next to each condition to edit that condition' do
      condition = Condition.create(
        date: Date.new(2017, 12, 11),
        max_temperature: 75.0,
        mean_temperature: 65.0,
        min_temperature: 55.0,
        mean_humidity: 75.0,
        mean_visibility: 10.0,
        mean_wind_speed: 11.0,
        precipitation: 0.23)

      visit condition_path(condition)

      click_button 'Edit'

      expect(current_path).to eq(edit_admin_condition_path(condition))
    end
    it 'they see a button next to each condition to delete that condition' do
      condition = Condition.create(
        date: Date.new(2017, 12, 11),
        max_temperature: 75.0,
        mean_temperature: 65.0,
        min_temperature: 55.0,
        mean_humidity: 75.0,
        mean_visibility: 10.0,
        mean_wind_speed: 11.0,
        precipitation: 0.23)

      visit condition_path(condition)

      click_button 'Delete'

      expect(current_path).to eq(conditions_path)
      expect(page).to have_content("Successfully deleted weather condition for #{condition.date.strftime('%m/%d/%Y')}")
    end
  end
end
