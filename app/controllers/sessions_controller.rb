class SessionsController < ApplicationController
  def new
    if @user = session[:user]
      redirect_to user_path(@user)
    end
    @user = User.new
  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if !@user
      @errors = ["Email not recognized"]
      render 'new'
    elsif @user.authenticate(params[:user][:password])
      session[:user] = @user.id
      redirect_to user_path(@user)
    else
      @errors = ["Unable to log in"]
      render 'new'
    end
  end

  def delete
    session[:user] = nil
    redirect_to root_path
  end
end
