require 'spec_helper'

describe FacebookRealtimeUpdatesController do
  include_context "common controller stuff" 

  describe "GET 'subscription'" do
    it "returns string when successful" do
      string = randomize_string
      Koala::Facebook::RealtimeUpdates.should_receive(:meet_challenge) { string }
      xhr :get, :subscription, {'hub.mode' => 'subscribe', 'hub.verify_token' => REALTIME_VERIFY_TOKEN['token']}
      response.body.should eq string
    end

    it "returns a message if not successful" do
      xhr :get, :subscription, {'hub.mode' => 'subscript', 'hub.verify_token' => ''}
      response.body.should eq I18n.t('errors.verify_token')
    end
  end

  describe "POST 'subscription'" do
    let(:params) {{"object"=>"user", 
      "entry"=>[{"uid"=>"", "id"=>"", "time"=>Time.now.to_i, "changed_fields"=>["feed"]}], 
      "facebook_realtime_update"=>{"object"=>"user", 
      "entry"=>[{"uid"=>"", "id"=>"", "time"=>Time.now.to_i, "changed_fields"=>["feed"]}]}}}

    before(:each) do
      @user = FactoryGirl.create(:user_facebook)
      sign_in @user 
      params['entry'][0]['uid'] = @user.uid
      params['entry'][0]['id'] = @user.uid
      params['facebook_realtime_update']['entry'][0]['uid'] = @user.uid
      params['facebook_realtime_update']['entry'][0]['id'] = @user.uid
    end

    it "creates post for a user" do
      #puts params.inspect 
      expect {
        xhr :post, :subscription, params
      }.to change(Post, :count).by 1
    end

    it "does not create a post for a user" do
     pending 
    end
  end

end
