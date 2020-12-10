require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe 'has many friendships' do
    it { should have_many(:friendships) }
    it { should have_many(:pending_friendships) }
  end
end

RSpec.describe User, type: :feature do
  let(:user1) { User.new(name: 'User 1', email: 'user1@gmail.com', password: '123456') }
  scenario 'User register successfully' do
    visit new_user_registration_path
    fill_in 'Name', with: 'user name test'
    fill_in 'Email', with: 'usertest@gmail.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_on 'Sign up'
    expect(page).to have_content('Welcome! You have signed up successfully.')
  end
  scenario 'User Sign in successfully' do
    user1.save
    visit root_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'
    expect(page).to have_content('Signed in successfully.')
  end
end