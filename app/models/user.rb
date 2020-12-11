class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships

  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :friends, through: :confirmed_friendships

  # def friends
  #   friends_array = friendships.map { |friendship| friendship.friend if friendship.confirmed }
  #   friends_array << pending_friendships.map { |friendship| friendship.user if friendship.confirmed }
  #   friends_array.compact
  # end

  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.confirmed }.compact
  end

  def friend_requests
    pending_friendships.map { |friendship| friendship.user unless friendship.confirmed }.compact.uniq
  end

  def confirm_friend(user)
    Friendship.create!(user_id: id, friend_id: user.id, confirmed: true)
  end

  def friend?(user)
    friends.include?(user)
  end
end
