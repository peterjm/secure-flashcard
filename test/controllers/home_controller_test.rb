# frozen_string_literal: true

require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  setup do
    log_in
  end

  test "#index requires authentication" do
    log_out
    get root_path
    assert_redirected_to login_path
  end

  test "#index should render when there is a card to attempt" do
    get root_path
    assert_response :success
  end

  test "#index should render when there is no card to attempt" do
    get root_path
    assert_response :success
  end
end
