class UsersController < ApplicationController
  def search
    @matches = []
    if params[:search]
      p params[:search]
      @matches = User.find_by(phone: params[:search])
      p @matches
    else
      @matches = []
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])

    render 'show'
    if @user = nil
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user] = @user.id
      redirect_to root_path
    else
      @errors = user.errors.full_messages
      render 'users#new'
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
