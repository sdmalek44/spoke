require 'rails_helper'

describe "admin user visits 'admin/stations/:name/edit" do
  before :each do
    user = User.create!(username: 'happyharry', email: 'email@email.email', password: 'turtles', role: 1, first_name: 'josh', last_name: 'mcbeth', address: '1111 tommy ln')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'admin can edit a station by filling in correct information' do
    station = Station.create!(name: 'Test Station', dock_count: 45, city: 'Chicago', installation_date: Date.new(2017, 3, 10))

    editted_name = 'Station Editted'
    editted_city = 'Denver'
    editted_dock_count = 25
    editted_installation_date = Date.new(2003, 3, 3)

    visit edit_admin_station_path(station)

    fill_in :station_name, with: editted_name
    fill_in :station_city, with: editted_city
    fill_in :station_dock_count, with: editted_dock_count
    fill_in :station_installation_date, with: editted_installation_date
    click_on 'Update Station'

    expect(current_path).to eq(station_path('station-editted'))
    expect(page).to have_content("Successfully updated #{editted_name}")
    expect(page).to have_content("City: #{editted_city}")
    expect(page).to have_content("Dock Count: #{editted_dock_count}")
    expect(page).to have_content("Installation Date: #{editted_installation_date.strftime('%d/%m/%Y')}")
  end
  it 'admin cannot edit a station if the do not fill in the correct information' do
    station = Station.create!(name: 'Test Station', dock_count: 45, city: 'Chicago', installation_date: Date.new(2017, 3, 10))

    editted_name = 'Station Editted'
    editted_city = 'Denver'
    editted_dock_count = 25
    editted_installation_date = Date.new(2003, 3, 3)

    visit edit_admin_station_path(station)

    fill_in :station_name, with: nil
    fill_in :station_city, with: editted_city
    fill_in :station_dock_count, with: editted_dock_count
    fill_in :station_installation_date, with: editted_installation_date
    click_on 'Update Station'

    expect(current_path).to eq(admin_station_path(station))
    expect(page).to have_content("Station was not updated. Try again.")
  end
end
