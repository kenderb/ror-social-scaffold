class Friendship < ApplicationRecord
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :user, foreign_key: 'friend_id'
  belongs_to :friendship_sender, class_name: 'User', foreign_key: 'user_id'

  validates :user_id, uniqueness: { scope: :friend_id, meesage: 'You have an invitation pending or are already friends' }
end
