# frozen_string_literal: true

require File.expand_path("../config/environment", __dir__)
require "rails/test_help"

OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
  info: {
    email: Rails.application.credentials.google.allowed_account,
  }
})

module ActiveSupport
  class TestCase
    def log_in
      post "/auth/google"
      follow_redirect!
    end

    def log_out
      delete logout_path
    end
  end
end
