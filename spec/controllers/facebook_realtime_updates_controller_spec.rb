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

    let(:response_with_tag) { #need this to be more random
      '{"data": [{
          "id" : "1",
          "message" : "message #tag",
          "picture" : "picture.jpeg",
          "link" : "http://link.link",
          "source" : "http://source.source",
          "name" : "name",
          "caption" : "caption"}]
        }'
    }


    let(:response) { #need this to be more random
      '{"data": [{
          "id" : "1",
          "message" : "message",
          "picture" : "picture.jpeg",
          "link" : "http://link.link",
          "source" : "http://source.source",
          "name" : "name",
          "caption" : "caption"}]
        }'
    }

    before(:each) do
      @user = FactoryGirl.create(:user_facebook)
      sign_in @user 
      params['entry'][0]['uid'] = @user.uid
      params['entry'][0]['id'] = @user.uid
      params['facebook_realtime_update']['entry'][0]['uid'] = @user.uid
      params['facebook_realtime_update']['entry'][0]['id'] = @user.uid
    end

    it "creates a posts for a user" do
      stub_request(:get, "http://graph.facebook.com/me/feed").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => "#{response_with_tag}", :headers => {})

      result = JSON.parse(response_with_tag) 
      expect {
        xhr :post, :subscription, params
      }.to change(Post, :count).by result['data'].count
    end

    it "creates a posts for a user but with no duplicates" do
      stub_request(:get, "http://graph.facebook.com/me/feed").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => "#{response_with_tag}", :headers => {})

      result = JSON.parse(response_with_tag) 
      expect {
        @user.posts.create(
            uid: response_with_tag['data']['id'],
            message: response_with_tag['data']['message'],
            picture: response_with_tag['data']['picture'],
            link: response_with_tag['data']['link'],
            source: response_with_tag['data']['source'],
            tag_list: "#tag"
        )
      }.to change(Post, :count).by result['data'].count

      result = JSON.parse(response_with_tag) 

      expect {
        xhr :post, :subscription, params
      }.to_not change(Post, :count)
    end

    it "does not create a post for a user if it does not have any tags" do
      stub_request(:get, "http://graph.facebook.com/me/feed").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.8'}).
        to_return(:status => 200, :body => "#{response}", :headers => {})

      expect {
        xhr :post, :subscription, params
      }.to_not change(Post, :count)
    end
    
    it "does not create a post for a user" do
      expect {
        pending 
      }.to change(Post, :count).by 1
    end
  end
end
