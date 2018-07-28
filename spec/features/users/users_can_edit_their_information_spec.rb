require 'rails_helper'

describe "A user visits /users/:id/edit" do
  it 'they can update their user information by entering valid info' do
    user = User.create(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    editted_username = 'editted_username'
    editted_password = '1234'
    editted_email = 'editted@email.com'
    editted_first_name = 'Matt'
    editted_last_name = 'Peters'
    editted_address = '123 Maple St'

    visit edit_user_path(user)

    fill_in :user_first_name, with: editted_first_name
    fill_in :user_last_name, with: editted_last_name
    fill_in :user_address, with: editted_address
    fill_in :user_username, with: editted_username
    fill_in :user_password, with: editted_password
    fill_in :user_email, with: editted_email

    click_button 'Update Account Info'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully updated your account')
    expect(page).to have_content(editted_username)
    expect(page).to have_content(editted_email)
    expect(page).to have_content(editted_first_name)
    expect(page).to have_content(editted_last_name)
    expect(page).to have_content(editted_address)
  end
  it 'they cannot edit information without valid info' do
    user = User.create(username: 'happyharry', email: 'email@email.email', password: 'turtles', first_name: 'hare', last_name: 'margret', address: '1234 dolly st.')
    visit login_path

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    editted_username = 'editted_username'
    editted_password = '1234'
    editted_email = 'editted@email.com'
    editted_first_name = 'Matt'
    editted_last_name = 'Peters'
    editted_address = '123 Maple St'

    visit edit_user_path(user)

    fill_in :user_first_name, with: nil
    fill_in :user_last_name, with: editted_last_name
    fill_in :user_address, with: editted_address
    fill_in :user_username, with: editted_username
    fill_in :user_password, with: editted_password
    fill_in :user_email, with: editted_email

    click_button 'Update Account Info'

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content('Your account was not updated. Try again.')
  end
end
