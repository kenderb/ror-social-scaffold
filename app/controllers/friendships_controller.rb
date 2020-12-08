class FriendshipsController < ApplicationController
  def index
    @users = User.all
  end
  

  def new
  end

def create
  user = User.find(params[:friend_id])
  @friendship = Friendship.new(user_id: current_user.id, friend_id: user.id, confirmed: false)
  if @friendship.save
    flash[:success] = "Friendship successfully created"
    redirect_to  friendships_path
  else
    flash[:error] = "Something went wrong"
    render 'new'
  end
end

  def destroy
  end

  # private
  # def friendship_params
  #   params.permit(:user_id, :friend_id, :confirmed)
  # end
end
