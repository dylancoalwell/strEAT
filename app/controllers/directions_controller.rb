class DirectionsController < ApplicationController
  def new
    @favorite = FavoriteLocation.find(params[:id])
  end
end
