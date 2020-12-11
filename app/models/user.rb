class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  has_many :friendships

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
    friends_array << pending_friendships.map { |friendship| friendship.user if friendship.confirmed }
    friends_array.compact
  end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    pending_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact.uniq
  end

  def confirm_friend(user)
    check_invitation(self, user)
    check_invitation(user, self)
  end

  def check_invitation(self_user, friend)
    received_invitation = self_user.pending_friendships.where(user_id: friend.id).first
    return if received_invitation.nil?

    received_invitation.confirmed = true
    received_invitation.save if received_invitation.valid?
  end

  def friend?(user)
    friends.include?(user)
  end
end
