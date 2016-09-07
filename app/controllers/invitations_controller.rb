class InvitationsController < ApplicationController
  def create
    @invitation = Invitation.new(params[:invitation])
    p @invitation
    @user = current_user
    @user.invitation
  end
  private
  def location_params
    params.require(:invitation).permit(:sender_lat, :sender_lng, :guest_lat, :guest_lng, :sender_id, :guest_id)
  end
end
