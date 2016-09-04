class FavoriteLocationsController < ApplicationController
  def index
    if !logged_in?
      redirect_to root_path
    end
  end

  def create
    if @user = current_user
      if @favorite_location = @user.favorite_locations.create(params[:favorite_location])
          # if request.xhr()
          # else
          # end
        # redirect to favorites location
        puts "functioning favorite_location creats functionality"
      else
        if request.xhr()
        else
        end
        @errors = @favorite_location.errors.full_messages
        # return error data
      end
    else
      # return message saying they must be logged in
    end
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address, :lat, :lng)
  end
end
