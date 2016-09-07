class InvitationsController < ApplicationController

  private
    def location_params
      params.require[:invitation].permit(:sender_lat, :sender_lng, :guest_lat, :guest_lng, :sender_id, :guest_id, :message)
    end
end
