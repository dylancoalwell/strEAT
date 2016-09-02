class UsersController < ApplicationController
  def new
    @user = User.new
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

  def show
    @user = User.find_by_id(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end
end
