class SessionsController < ApplicationController
  def new
    if logged_in?
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if !user
      @errors = ["Email not recognized"]
      render 'new'
    elsif user.authenticate(params[:user][:password])
      current_user = user
      redirect_to root_path
    else
      @errors = ["Unable to log in"]
      render 'new'
    end
  end
end
