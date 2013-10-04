class FacebookRealtimeUpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:subscription]

  def subscription
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] == REALTIME_VERIFY_TOKEN['token']
        render :text=>Koala::Facebook::RealtimeUpdates.meet_challenge(params, REALTIME_VERIFY_TOKEN['token'])
      else 
        render :text => 'Failed to authorize facebook challenge request'
      end
    elsif request.method == "POST"
      Rails.logger.info(JSON.PARse(request.body.read))
      updated_obj = JSON.parse(request.body.read)
      puts updated_obj
      render :text => "Thanks for the update"
    end
  end
end
