class FriendsController < ApplicationController

  def get
  end

  def index
    # p params[:id]
    @user = User.find(params[:user_id])
    @friends = @user.friends.all
  end


  def destroy
  end


end
