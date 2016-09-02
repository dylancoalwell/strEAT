class SessionsController < ApplicationController
  def new
    @user = User.find_by(email: params[:email])

  end
end
