module FriendshipsHelper
  def friend_status(user)
    return if user == current_user

    if current_user.pending_friends.include?(user) || user.pending_friends.include?(current_user)
      render 'friendships/pendind_friend_request'
    elsif current_user.friend?(user) || user.friend?(current_user)
      render 'friendships/already_friends'
    else
      render 'friendships/add_friend_button', user: user
    end
  end
end
