module FriendshipsHelper
  def friend_status(user)
    return if user == current_user
    if !current_user.friendships.where(friend_id: user.id, confirmed: false ).empty? || !user.friendships.where(friend_id: current_user.id, confirmed: false ).empty?
      render 'friendships/pendind_friend_request'
    elsif !current_user.friendships.where(friend_id: user.id, confirmed: true ).empty? || !user.friendships.where(friend_id: current_user.id, confirmed: true ).empty?
      
      render 'friendships/already_friends'
    else
      render 'friendships/add_friend_button', user: user
    end
    
  end
end
