class TextsController < ApplicationController
  respond_to :json
  skip_before_filter :verify_authenticity_token

  def index
  	render json: { error: 'Access Denied'}, status: 401
  end

  def create
  	twilio_sid = "ACd4c7174bd37083fd95f8661c0c3d89a0"
	twilio_token = "5bca1b3ae1171cad2445f85052a9af22"
	@twilio_client = Twilio::REST::Client.new twilio_sid, twilio_token

	begin
	tonumber = params["text"]["tonumber"]
	fromnumber = params["text"]["fromnumber"]
	message = params["text"]["message"]
	@twilio_client.account.messages.create(
      :from => fromnumber,
      :to => tonumber,
      :body => message
    )
  render json: "Success: message '#{message}' sent to {tonumber} "

	rescue Twilio::REST::RequestError => e
      render json: e.message
  end
  end


end
