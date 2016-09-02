class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.create!(user_params)
    if @user.id
      redirect_to root_path
    else
      render 'users#new'
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end
end
