class Authenticator
  class_attribute :google_account

  def self.google_account
    @google_account || Rails.application.secrets.google_account
  end

  attr_reader :session

  def initialize(session)
    @session = session
  end

  def authenticate(data)
    log_in if correct_google_account?(data)
  end

  def log_in
    session[:logged_in] = true
  end

  def log_out
    session.delete(:logged_in)
  end

  def logged_in?
    !!session[:logged_in]
  end

  private

  def correct_google_account?(account)
    account == self.class.google_account
  end
end
