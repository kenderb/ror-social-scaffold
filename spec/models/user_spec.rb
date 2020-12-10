require 'rails_helper'
require 'spec_helper'
require 'capybara/rspec'

RSpec.describe User, type: :model do
  let(:user1) { User.create(name: 'User 1', email: 'user1@gmail.com', password: '123456') }
  let(:user2) { User.create(name: 'User 2', email: 'user1@gmail.com', password: '123456') }
  scenario 'User sign in successfully' do
    visit '/users/sign_up'
    # fill_in 'Name', with: user1.name
    fill_in 'Email', with: user1.email
    fill_in 'Password (6 characters minimum)', with: user.password
    # fill_in 'Password Confirmation', with: user.password
    click_on 'LOG IN'
    sleep(3)
    expect(page).to have_content('Signed in successfully.')
  end

  describe 'has many categories' do
    it { should have_many(:friendships) }
    it { should have_many(:pending_friendships) }
  end
end