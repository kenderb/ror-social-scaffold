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
