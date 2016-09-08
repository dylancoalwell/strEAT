class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user])
  end

  def logged_in?
    current_user != nil
  end



  def use_twilio(user, message_text, invitation_id)
    account_sid = ENV['TWILIO_ACCT_SID']
    auth_token = ENV['TWILIO_AUTH_KEY']
    @client = Twilio::REST::Client.new account_sid, auth_token
    Twilio.configure do |config|
      config.account_sid = account_sid
      config.auth_token = auth_token
    end

    if invitation_id == nil
      body_message = "#{current_user.first_name} #{current_user.last_name} says: #{message_text}"
    else
      body_message = "#{current_user.first_name} #{current_user.last_name} has sent you an invitation: http://streat.herokuapp.com/invitations/" + invitation_id.to_s
    end
    puts body_message
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+12013801772  ',
      to: user.phone,
      body: body_message
    )
  end
end
