class FacebookRealtimeUpdatesController < ApplicationController
  def subscription
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] =='stringToken' 
        render :text => params['hub.challenge']
      else 
        render :text => 'Failed to authorize facebook challenge request'
      end
    elsif request.method == "POST"
      updated_obj = JSON.parse(request.body.read)
      puts updated_obj
      render :text => "Thanks for the update"
    end
  end
end
