class FriendshipsController < ApplicationController
  def index
    @friendship = Friendship.all
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

  def edit
  end
  
  def update
    friend = Friendship.find(params[:friend_id])
    current_user.confirm_friend(friend)
    redirect_to root_url
  end
  

  def destroy
    # @friendship = Friendship.find(params[:friendship_id])
    # @friendship.destroy
  end  

  private
  def friendship_params
    params.require(:friendship).permit(:user_id, :friend_id, :confirmed)
  end
end
