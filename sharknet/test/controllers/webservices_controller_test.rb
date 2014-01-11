require 'test_helper'

class WebservicesControllerTest < ActionController::TestCase
  test "should get showwork" do
    get :showwork
    assert_response :success
  end

  test "should get showvacation" do
    get :showvacation
    assert_response :success
  end

end
