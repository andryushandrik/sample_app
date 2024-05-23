require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path user: { name:  "",
                              email: "user@invalid",
                              password:              "foo",
                              password_confirmation: "bar" }
    end
    assert_template 'users/new'
    # assert_select 'div#error_explanation', "The form contains 4 errors.
    #
    #
    #     Name can't be blank
    #     Email is invalid
    #     Password confirmation doesn't match Password
    #     Password is too short (minimum is 6 characters)"
    # assert_select 'div.field_with_errors', "Name"
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
      follow_redirect!
    end
    assert_template 'users/show'
    assert_not !flash[:success]
    assert is_logged_in?
  end
end
