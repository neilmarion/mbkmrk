module Realtimeable
  extend ActiveSupport::Concern

  include do
    skip_before_filter :verify_authenticity_token, :only => [:subscription]
  end

  def subscription
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] == REALTIME_VERIFY_TOKEN['token']
        render :text=>Koala::Facebook::RealtimeUpdates.meet_challenge(params, REALTIME_VERIFY_TOKEN['token'])
      else 
        render :text => I18n.t('errors.verify_token') 
      end
    elsif request.method == "POST"
      updated_obj = JSON.parse(request.body.read)
      puts updated_obj
      render :text => "Thanks for the update"
    end
  end
end
