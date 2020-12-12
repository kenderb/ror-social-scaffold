require 'rails_helper'
require 'spec_helper'

RSpec.describe Friendship, type: :feature do
  let(:user1) { User.create!(name: 'User 1', email: 'user1@gmail.com', password: '123456') }
  let(:user2) { User.create!(name: 'User 2', email: 'user2@gmail.com', password: '123456') }

  scenario 'Sent a friend request' do
    user1.save
    user2.save
    visit root_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'
    visit users_path
    click_on 'Add Friend'
    expect(page).to have_content('Pending Invitation')
  end

  scenario 'User Sign in successfully' do
    user1.save
    user2.save
    visit root_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'
    visit users_path
    click_on 'Add Friend'
    click_on 'Sign out'
    fill_in 'Email', with: user2.email
    fill_in 'Password', with: user2.password
    click_on 'Log in'
    click_on 'friend requests'
    expect(page).to have_content('Accept')
  end
end
