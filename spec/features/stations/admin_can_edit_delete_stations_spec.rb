require 'rails_helper'

describe "admin user visits '/show/:id" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  it 'can see all same information as a default user' do
    station_1 = Station.create!(name: 'Test Station 1', dock_count: 20, city: 'Chicago', installation_date: Date.new(2018, 6, 21))
    station_2 = Station.create!(name: 'Test Station 2', dock_count: 25, city: 'Denver', installation_date: Date.new(2017, 6, 21))
    station_3 = Station.create!(name: 'Test Station 3', dock_count: 30, city: 'Dallas', installation_date: Date.new(2016, 6, 21))

    visit stations_path

    expect(page).to have_content("#{station_1.name}")
    expect(page).to have_content("Dock Count: #{station_1.dock_count}")
    expect(page).to have_content("City: #{station_1.city}")
    expect(page).to have_content("Installation Date: #{station_1.installation_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{station_2.name}")
    expect(page).to have_content("Dock Count: #{station_2.dock_count}")
    expect(page).to have_content("City: #{station_2.city}")
    expect(page).to have_content("Installation Date: #{station_2.installation_date.strftime('%m/%d/%Y')}")
    expect(page).to have_content("#{station_3.name}")
    expect(page).to have_content("Dock Count: #{station_3.dock_count}")
    expect(page).to have_content("City: #{station_3.city}")
    expect(page).to have_content("Installation Date: #{station_3.installation_date.strftime('%m/%d/%Y')}")
  end

  it 'they can see a button next to each station to edit a station' do
    station = Station.create!(name: 'test1', dock_count: 25, city: 'Denver', installation_date: Date.new(2017, 3, 10))

    visit stations_path

    click_button 'Edit'

    expect(current_path).to eq(edit_station_path(station))
  end

  it 'they can see a button next to each station to edit a station' do
    station = Station.create!(name: 'test1', dock_count: 25, city: 'Denver', installation_date: Date.new(2017, 3, 10))

    visit stations_path

    click_button 'Delete'

    expect(current_path).to eq(stations_path)
    expect(page).to have_content("You have successfully deleted #{station.name} station")  
  end
end
