require 'spec_helper'

describe FacebookRealtimeUpdatesController do
  describe "GET 'subscription'" do
    it "returns string when successful" do
      xhr :get, :subscription, {'hub.mode' => 'subscript', 'hub.verify_token' => REALTIME_VERIFY_TOKEN['token']}
      puts response.body.inspect
    end

    it "returns a message if not successful" do
      xhr :get, :subscription, {'hub.mode' => 'subscript', 'hub.verify_token' => ''}
      response.body.should eq I18n.t('errors.verify_token')
    end
  end

  describe "POST 'subscription'" do
    pending 
  end

end
