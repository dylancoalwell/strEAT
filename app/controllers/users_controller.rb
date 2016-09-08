require 'rubygems'
require 'twilio-ruby'

class UsersController < ApplicationController

  def index
    if @user = User.find_by(id: session[:user])
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
        message_text = "I have invited you to join strEAT. Click here to register and join the fun! https://streat.herokuapp.com/users/new"
        use_twilio(user, message_text, nil)
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
    guest = User.find(params[:id])
    if request.xhr?
      message_text = params[:message]
    else
      message_text = params[:invite][:message]
    end
    invitation = Invitation.new(sender_id: current_user.id, guest_id: guest.id, message: message_text, sender_lat: params[:sender_lat], sender_lng: params[:sender_lng])
    if invitation && invitation.save
      puts "success"
      if message_text != ""
        use_twilio(guest, message_text, invitation.id)
        if request.xhr?
          redirect_to user_path(current_user)
        else
          redirect_to user_friends_path(current_user)
        end
      else
        redirect_to user_path(guest)
      end
    else
      puts "failure"
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




end
