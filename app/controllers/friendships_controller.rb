class FriendshipsController < ApplicationController
  def index
  end

  def create
    @friendship = Friendship.create(friendship_params)
    if @friendship.save
      flash[:success] = "Friendship successfully created"
      redirect_to  users_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def update
    friend = User.find(params[:id])
    
    current_user.confirm_friend(friend)
    redirect_to friendships_path
  end
  

  def destroy
    friendship = Friendship.where(user_id: params[:id], friend_id: current_user.id, confirmed: false )
    friendship[0].destroy
    redirect_to friendships_path
  end  

  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
