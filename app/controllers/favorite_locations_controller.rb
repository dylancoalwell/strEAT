class FavoriteLocationsController < ApplicationController
  def index
    if !logged_in?
      redirect_to root_path
    end
  end

  def new
    redirect_to root_path unless logged_in?
    @user = User.find(params[:user_id])
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
      if @favorite_location = @user.favorite_locations.create(favorite_location_params)
      else
        @errors = @favorite_location.errors.full_messages
      end
    else
    end
  end

  def show
    @favorite = FavoriteLocation.find(params[:id])
    if request.xhr?
      puts "HHHHHHHHHHHHHHHHHHHHHHHHH--------ajax request-------HHHHHHHHHHHHHHHHHHHHHHH"
      render :json => @favorite
    else
      puts "--------------------normal request--"
    end
  end

  private

  def favorite_location_params
    params.require(:favorite_location).permit(:name, :address, :lat, :lng)
  end
end
