class FavoriteLocationsController < ApplicationController
  def index
    # if !logged_in?
    #   redirect_to root_path
    # end
  end

  def create
    puts "\n\n\n in create"
    puts params.inspect
    @user = User.find_by(id: params[:id])
    if @user == current_user
      puts "user is #{@user.first_name}"
      puts "user is #{current_user.first_name}"
      if @favorite_location = @user.favorite_locations.create(favorite_location_params)
          # if request.xhr()
          # else
          # end
        # redirect to favorites location
        puts "\n\nfunctioning favorite_location creats functionality"
      else

        # commenting out xhr for the moment
        # if request.xhr()
        # else
        # end
        @errors = @favorite_location.errors.full_messages
        puts @errors
        # return error data
      end
    else
      puts "\n\nMust be logged in"
      # return message saying they must be logged in
    end
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address, :lat, :lng)
  end
end
