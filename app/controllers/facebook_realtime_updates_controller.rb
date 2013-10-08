class FacebookRealtimeUpdatesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:subscription]
  protect_from_forgery with: :null_session

  include Realtimeable
end
