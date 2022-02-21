# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "#new renders successfully when logged out" do
    get login_path
    assert_response :success
  end

  test "#new redirects when logged in" do
    log_in
    get login_path
    assert_redirected_to root_path
  end

  test "#create logs in when given successful auth params" do
    log_in
    assert_redirected_to root_path
  end

  test "#create redirects with error code when login not successful" do
    log_in(mock_auth: successful_google_auth_hash(email: "unexpected.email@example.com"))
    assert_response :unprocessable_entity
  end

  test "#create redirects when logged in" do
    log_in
    log_in
    assert_redirected_to root_path
  end

  test "#error renders with error code when logged out" do
    log_in(mock_auth: :invalid_credentials)
    follow_redirect! # follows the redirect from the callback phase to the error page
    assert_response :unprocessable_entity
  end

  test "#error redirects when logged in" do
    log_in
    log_in(mock_auth: :invalid_credentials)
    follow_redirect! # follows the redirect from the callback phase to the error page
    assert_redirected_to root_path
  end

  test "#destroy logs out when logged in" do
    log_in
    delete logout_path
    assert_redirected_to login_path
  end

  test "#destroy does nothing when logged out" do
    delete logout_path
    assert_redirected_to login_path
  end
end
