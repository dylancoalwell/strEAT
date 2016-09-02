class UsersController < ApplicationController
  def new
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render 'users#new'
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password)
  end
end
