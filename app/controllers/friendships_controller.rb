class FriendshipsController < ApplicationController
  def index
    @users = User.all
  end
  

  def new
    @friendship = Friendship.new
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

  def destroy
  end

  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
