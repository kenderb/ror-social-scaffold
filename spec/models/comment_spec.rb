require 'rails_helper'
require 'spec_helper'

RSpec.describe Comment, type: :model do
  describe 'has many friendships' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end

  describe 'Should no be the same relation' do
    it 'new friend request' do
      comment = Comment.new(user_id: 10, post_id: 12, content: 'Some text for the content')
      expect(comment.save).to eq(false)
    end
  end
end
