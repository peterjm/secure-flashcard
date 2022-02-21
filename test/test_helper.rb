# frozen_string_literal: true

require File.expand_path("../config/environment", __dir__)
require "rails/test_help"

OmniAuth.config.test_mode = true

module ActiveSupport
  class TestCase
    setup do
      OmniAuth.config.mock_auth[:google] = nil
    end

    def inspect
      # overriding this so it doesn't print hundreds of lines of output on NoMethodError
      self.class.name
    end

    def log_in(mock_auth: successful_google_auth_hash)
      OmniAuth.config.mock_auth[:google] = mock_auth
      post "/auth/google"
      follow_redirect!
    end

    def log_out
      delete logout_path
    end

    def successful_google_auth_hash(email: Rails.application.credentials.google.allowed_account)
      OmniAuth::AuthHash.new({ info: { email: email } })
    end
  end
end
