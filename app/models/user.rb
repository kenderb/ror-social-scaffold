class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  # has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'

  def friends
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}
    friends_array + pending_friendships.map{|friendship| friendship.user if friendship.confirmed}
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  # Users who have requested to be friends
  def friend_requests
    pending_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact.uniq
  end

  def confirm_friend(user)
    received_invitation = pending_friendships.where(user_id: user.id).first
    return if received_invitation.nil?
    received_invitation.confirmed = true
    if received_invitation.valid?
      received_invitation.save
    end

    received_invitation2 = user.pending_friendships.where(user_id: id).first
    received_invitation2.confirmed = true
    if received_invitation2.valid?
      received_invitation2.save
    end
  end

  def friend?(user)
    friends.include?(user)
  end

end

