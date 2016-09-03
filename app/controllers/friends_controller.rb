class FriendsController < ApplicationController

  def get
  end

  def index
    # p params[:id]
    puts request
    @user = User.find(params[:user_id])
    @friends = @user.friends.all
  end

  def new
  end

  def destroy
  end

  def friend_unfriend
    @user = User.find(params[:id])
    if current_user.friends_with? @user
      current_user.befriend @user
    else
      current_user.unfriend @user
    end
  end


end
