require 'rails_helper'
require 'spec_helper'

RSpec.describe Friendship, type: :model do
  let(:friendship) { Friendship.new(user_id: 10, friend_id: 12, confirmed: false) }

  describe 'has many friendships' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  describe 'Should no be the same relation' do
    it 'new friend request' do 
      rel = Friendship.new(user_id: 10, friend_id: 12, confirmed: false)
      expect(rel.save).to eq(false)
    end
  end
end

RSpec.describe Friendship, type: :feature do
  let(:user1) { User.create(name: 'User 1', email: 'user1@gmail.com', password: '123456') }
  let(:user2) { User.create(name: 'User 2', email: 'user2@gmail.com', password: '123456') }

  scenario 'User Sign in successfully' do
    user1.save
    visit root_path
    fill_in 'Email', with: user1.email
    fill_in 'Password', with: user1.password
    click_on 'Log in'
    visit users_path
    click_on
    expect(page).to have_content('Signed in successfully.')
  end
end
