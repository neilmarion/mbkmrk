module Realtimeable
  extend ActiveSupport::Concern

  include do
    skip_before_filter :verify_authenticity_token, :only => [:subscription]
    protect_from_forgery with: :null_session
  end

  def subscription
    if request.method == "GET"
      if params['hub.mode'] =='subscribe' && params['hub.verify_token'] == REALTIME_VERIFY_TOKEN['token']
        render :text=>Koala::Facebook::RealtimeUpdates.meet_challenge(params, REALTIME_VERIFY_TOKEN['token'])
      else 
        render :text => I18n.t('errors.verify_token') 
      end
    elsif request.method == "POST"
      user = User.where(uid: params['entry'][0]['uid']).first
      Resque.enqueue(UserPostsUpdater, user.id)
      render :text => "Thanks for the update"
    end
  end
end
