class FavoriteLocationsController < ApplicationController
  def index
    redirect_to root_path unless logged_in?
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find_by(id: params[:id])
    if @user == current_user
      if @favorite_location = @user.favorite_locations.create(favorite_location_params)
        # respond_to :html, :js
        render :json => {user_id: @user.id}
      else
        @errors = @favorite_location.errors.full_messages
      end
    else
    end
  end

  def show
    @favorite = FavoriteLocation.find(params[:id])
    if request.xhr?
      render :json => @favorite
    end
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address, :lat, :lng)
  end
end
