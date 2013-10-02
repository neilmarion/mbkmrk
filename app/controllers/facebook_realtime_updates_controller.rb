class FacebookRealtimeUpdatesController < ApplicationController
  VERIFY_TOKEN = "e9prWj1M6nkc152"

  def subscription
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] == VERIFY_TOKEN
        render :text=>Koala::Facebook::RealtimeUpdates.meet_challenge(params, VERIFY_TOKEN)
      else 
        render :text => 'Failed to authorize facebook challenge request'
      end
    elsif request.method == "POST"
      Rails.logger.info("update-------------------------------") 
      Rails.logger.info(JSON.parse(request.body.read))
      updated_obj = JSON.parse(request.body.read)
      puts updated_obj
      render :text => "Thanks for the update"
    end
  end
end
