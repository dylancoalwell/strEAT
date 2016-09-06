class DirectionsController < ApplicationController
  def new
    @location = FavoriteLocation.find(params[:id])
  end
end
