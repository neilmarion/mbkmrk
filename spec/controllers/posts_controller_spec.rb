require 'spec_helper'

describe PostsController do
  include_context "common controller stuff" 

  describe "GET 'index'" do
    it "returns http success" do
      user = FactoryGirl.create(:user_facebook)
      sign_in user 
      get 'index'
      response.should be_success
    end
  end

end
