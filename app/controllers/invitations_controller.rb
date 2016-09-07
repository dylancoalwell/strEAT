class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find(params[:id])
  end

  def accept
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to user_path(current_user)
  end

  private
    def location_params
      params.require[:invitation].permit(:sender_lat, :sender_lng, :guest_lat, :guest_lng, :sender_id, :guest_id, :message)
    end
end
