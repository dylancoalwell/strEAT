require 'rubygems'
require 'twilio-ruby'

class UsersController < ApplicationController
  def search
    if params[:search]
      p params[:search]
      if @matches = User.find_by(phone: params[:search])
        @matches
      else
        redirect_to user_new_friend_path(current_user)
      end
    else
      redirect_to user_new_friend_path(current_user)
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])

    render 'show'
    if @user == nil
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      redirect_to root_path
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    current_user.befriend @user
    redirect_to user_friends_path(current_user)
  end

  def destroy
    @user = User.find(params[:id])
    current_user.unfriend @user
    redirect_to user_friends_path(current_user)
  end

  def message
    user = User.find(params[:id])
    message = params[:invite][:message]
    account_sid = 'ACfa62a836d6967bb1831081646c49ba51'
    auth_token = '9242fa23628291a0f55a4927fe86db16'
    @client = Twilio::REST::Client.new account_sid, auth_token
    Twilio.configure do |config|
      config.account_sid = account_sid
      config.auth_token = auth_token
    end
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+12013801772  ',
      to: user.phone,
      body: message
    )
    redirect_to user_friends_path(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end

  def friends
    @user= User.find(params[:id])
    @friends = @user.friends
  end

  def find_friend
    @friend = User.find_by(phone: params[:find_friend][:phone_number])
  end


end
