# frozen_string_literal: true

require "test_helper"

class AuthenticatorTest < ActiveSupport::TestCase
  setup do
    @session = {}
    @authenticator = Authenticator.new(@session, account: "valid account")
  end

  test "#log_in returns true with the correct account" do
    assert @authenticator.log_in("valid account")
    assert_equal true, @session[:logged_in]
  end

  test "#log_in returns false with an incorrect account" do
    assert_not @authenticator.log_in("invalid account")
    assert_empty @session
  end

  test "#log_out clears the logged_in value" do
    session = { logged_in: true }
    authenticator = Authenticator.new(session, account: "anything")
    authenticator.log_out
    assert_empty session
  end

  test "#logged_in? returns true when logged in" do
    @authenticator.log_in("valid account")
    assert @authenticator.logged_in?
  end

  test "#logged_in? returns false when not logged in" do
    assert_not @authenticator.logged_in?
  end

  test "#logged_in? returns false after log out" do
    @authenticator.log_in("valid account")
    @authenticator.log_out
    assert_not @authenticator.logged_in?
  end
end
