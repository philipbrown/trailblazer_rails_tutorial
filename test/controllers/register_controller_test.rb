require "test_helper"

class RegisterControllerTest < ActionController::TestCase
  test "should display register form" do
    get :new

    assert_response :success
  end

  test "should fail to register with invalid data" do
    post :create, user: {email: "", password: ""}

    assert_response 400
  end

  test "should register new user" do
    post :create, user: {email: "name@domain.com", password: "password"}

    assert_response 302
    assert_redirected_to login_url
  end
end
