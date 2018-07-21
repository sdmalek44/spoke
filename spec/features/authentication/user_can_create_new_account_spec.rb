require 'rails_helper'

describe 'when user visits /login page' do
  it 'can create a new account' do
    visit login_path

    click_link "Create Account"

    expect(current_path).to eq(new_user_path)
    username = 'happyharry'

    fill_in :user_email, with: 'email@email.email'
    fill_in :user_username, with: username
    fill_in :user_password, with: 'turtles'

    click_button "Create Account"

    expect(current_path).to eq(dashboard_index_path)
  end
end
