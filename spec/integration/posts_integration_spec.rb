require 'rails_helper'
require 'spec_helper'
# rubocop:disable  Metrics/BlockLength
RSpec.describe PostsController, type: :feature do
  context 'timeline displays friends posts' do
    let(:user) { User.create(id: '1', name: 'Kender', email: 'kender@mail.com', password: '123456') }

    scenario 'display current_user posts' do
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      fill_in 'post_content', with: 'Create a post for testing'
      click_button 'Save'
      visit root_path
      expect(page).to have_content('Create a post for testing')
    end

    scenario 'display friends posts' do
      user2 = User.create(id: '2', name: 'Jose', email: 'Jose@mail.com', password: '123456')
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      visit users_path
      click_link 'Add Friend'
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      click_on 'friend requests'
      click_link 'Accept'
      visit root_path
      fill_in 'post_content', with: 'Add posts with For testing and For your friend'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).to have_content('For your friend')
    end

    scenario 'cannot see posts if are not friends' do
      user2 = User.create(id: '2', name: 'Mick', email: 'mick@example.com', password: 'password')
      visit new_user_session_path
      fill_in 'user_email', with: user2.email
      fill_in 'user_password', with: user2.password
      click_button 'Log in'
      visit root_path
      fill_in 'post_content', with: 'Testing posts with rspec in rails and I am a friend'
      click_button 'Save'
      sleep(2)
      click_link 'Sign out'
      visit new_user_session_path
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).not_to have_content('and I am a friend')
    end
  end
  # rubocop:enable  Metrics/BlockLength
end
