class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :user_id,
            uniqueness: { scope: :friend_id, meesage: 'You have an invitation pending or are already friends' }
end
