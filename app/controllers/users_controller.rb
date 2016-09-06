require 'rubygems'
require 'twilio-ruby'

class UsersController < ApplicationController

  def index
    if @user = User.find_by(id: session[:user_id])
      redirect_to user_path(@user)
    else
      redirect_to new_session_path
    end
  end


  def search
    if params[:search] != ""
      if @matches = User.find_by(phone: params[:search])
        @matches
      else
        user = User.new(phone: params[:search])
        message_text = "I have invited you to join strEAT. Click here to register and join the fun! http://streat.herokuapp.com/users/new"
        use_twilio(user, message_text)
        redirect_to user_path(current_user)
      end
    else
      redirect_to user_new_friend_path(current_user)
    end
  end

  def new
    @user = User.new
    @errors = @user.errors.full_messages
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
      redirect_to user_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def user_update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      @errors = @user.errors.full_messages
      render 'edit'
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
    message_text = params[:invite][:message]
    if message_text != ""
      use_twilio(user, message_text)
      redirect_to user_friends_path(current_user)
    else
      redirect_to user_path(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation, :avatar)
  end

  def friends
    @user= User.find(params[:id])
    @friends = @user.friends
  end

  def find_friend
    @friend = User.find_by(phone: params[:find_friend][:phone_number])
  end



  def use_twilio(user, message_text)
    account_sid = ENV['TWILIO_ACCT_SID']
    auth_token = ENV['TWILIO_AUTH_KEY']
    @client = Twilio::REST::Client.new account_sid, auth_token
    Twilio.configure do |config|
      config.account_sid = account_sid
      config.auth_token = auth_token
    end
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+12013801772  ',
      to: user.phone,
      body: "#{current_user.first_name} says: #{message_text}"
    )
  end
end
