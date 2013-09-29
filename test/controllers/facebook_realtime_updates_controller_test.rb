require 'test_helper'

class FacebookRealtimeUpdatesControllerTest < ActionController::TestCase
  test "should get subscription" do
    get :subscription
    assert_response :success
  end

end
