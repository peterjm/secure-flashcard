# frozen_string_literal: true

class Authenticator
  attr_reader :session, :allowed_account

  def initialize(
    session,
    account: Rails.application.credentials.google.allowed_account
  )
    @session = session
    @allowed_account = account
  end

  def log_in(account)
    if account == allowed_account
      session[:logged_in] = true
    else
      false
    end
  end

  def log_out
    session.delete(:logged_in)
  end

  def logged_in?
    !!session[:logged_in]
  end
end
