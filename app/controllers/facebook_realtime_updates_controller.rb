class FacebookRealtimeUpdatesController < ApplicationController
  VERIFY_TOKEN = 'e9prWj1M6nkc152';

  def create
    Rails.logger.info("UPDATED -------------------------")
    Rails.logger.info(params)
  end

  def index
    render :text=>Koala::Facebook::RealtimeUpdates.meet_challenge(params, VERIFY_TOKEN)
  end
end
