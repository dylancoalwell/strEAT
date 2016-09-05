class FriendsController < ApplicationController

  def get
  end

  def index
    # p params[:id]
    # puts request
    @user = User.find(params[:user_id])
    @friends = @user.friends.all
  end

  def new
  end

  def destroy
  end

  def add_friend
    @user = User.find(params[:id])
    @user.befriend current_user
    current_user.befriend @user
  end

  def unfriend
    @user = User.find(params[:user_id])
    @user.unfriend current_user
    current_user.unfriend @user
  end


end
