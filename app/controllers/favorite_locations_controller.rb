class FavoriteLocationsController < ApplicationController
  def index
    puts params.inspect
    if logged_in?
      user = User.find(params[:user_id])
      @favorite_locations = user.favorite_locations
      render 'index'
    else
      redirect_to root_path
    end
  end

  def new
  end

  def create
    @user = User.find_by(id: params[:id])
    # if @user.id == 20
    if @user == current_user
      @favorite_location = @user.favorite_locations.new(favorite_location_params)
      if @favorite_location.save
          if request.xhr?

           render :nothing => true, status: 200
        # redirect to favorites location
          end
      else
        @errors = @favorite_location.errors.full_messages
        puts @errors

        # commenting out xhr for the moment
        if request.xhr?
          render json: @errors.to_json, status: 404
        # else
        end
        # return error data
      end
    else
      if request.xhr?
        render :nothing => true, status: 403
      end
    end
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address, :lat, :lng)
  end
end
