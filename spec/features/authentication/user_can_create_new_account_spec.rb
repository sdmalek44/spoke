require 'rails_helper'

describe 'when user visits /login page' do
  it 'can create a new account' do
    visit login_path

    click_link "Create Account"

    expect(current_path).to eq(new_user_path)
    username = 'happyharry'
    address = '1212 tombob street'

    fill_in :user_email, with: 'email@email.email'
    fill_in :user_username, with: username
    fill_in :user_password, with: 'turtles'
    fill_in :user_first_name, with: 'bobbybob'
    fill_in :user_last_name, with: 'billybob'
    fill_in :user_address, with: address

    click_button "Create Account"

    expect(current_path).to eq(dashboard_path)
  end
  it 'renders new user view if incorrect input' do

        visit new_user_path

        username = 'happyharry'

        fill_in :user_email, with: 'email@email.email'
        fill_in :user_username, with: ''
        fill_in :user_password, with: 'turtles'

        click_button "Create Account"

        expect(current_path).to eq(users_path)
        expect(page).to have_content("Invalid input. Please try again.")
  end
end
