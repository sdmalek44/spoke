require 'rails_helper'

describe "admin user visits '/stations/new" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'user can create new station by filling in correct information' do
    visit new_admin_station_path

    fill_in :station_name, with: 'Test Station'
    fill_in :station_dock_count, with: 20
    fill_in :station_city, with: 'Denver'
    fill_in :station_installation_date, with: Date.new(2014, 1, 1)
    click_on 'Create Station'

    expect(current_path).to eq(station_path(Station.last))
    expect(page).to have_content("Successfully created Test Station")
  end
  it 'user cannot create new station without inputting all information' do
    visit new_admin_station_path

    fill_in :station_name, with: nil
    fill_in :station_dock_count, with: 20
    fill_in :station_city, with: 'Denver'
    fill_in :station_installation_date, with: Date.new(2014, 1, 1)
    click_on 'Create Station'

    expect(current_path).to eq(admin_stations_path)
    expect(page).to have_content("Station not created, try again")
  end
end
