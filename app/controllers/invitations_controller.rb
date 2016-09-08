class InvitationsController < ApplicationController
  def show
    @invitation = Invitation.find(params[:id])
  end

  def accept
    @invitation = Invitation.find(params[:id])
    puts params
    if request.xhr?
      @invitation.guest_lat = params[:guest_lat]
      @invitation.guest_lng = params[:guest_lng]
      @invitation.accepted = true
      if @invitation.save
        # twillio call goes here
        sender = User.find(@invitation.sender_id)
        guest = User.find(@invitation.guest_id)
        message_text = "Your Invitation from #{guest.first_name} #{guest.last_name} has been accepted. Here is your route http://streat.herokuapp.com/invitations/#{@invitation.id}/route"
        use_twilio(sender, message_text, nil)
        redirect_to invitation_route_path(@invitation)
      else
        # render :errors => "you done messed up", status: 401}
      end
    end
  end

  def destroy
    @invitation = Invitation.find(params[:id])
    @invitation.destroy
    redirect_to user_path(current_user)
  end

  def route
    @invitation = Invitation.find(params[:id])
    if request.xhr?
      puts "testing things out but hey things are working, maybe?"
    else
      puts "one more time for the kids in the back"
    end
    puts "I don't want to eat my vegetables, even though they are tasty"
  end

  private
    def location_params
      params.require[:invitation].permit(:sender_lat, :sender_lng, :guest_lat, :guest_lng, :sender_id, :guest_id, :message)
    end
end
