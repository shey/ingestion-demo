require "test_helper"

class Api::AlertsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_alerts_create_url
    assert_response :success
  end
end
