class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def return_to_path=(path)
    session[:return_to] = path
  end

  def redirect_to_return_path
    redirect_to session[:return_to] || root_path
    session.delete(:return_to)
  end

  def log_in!(credentials)
    authenticator.authenticate(credentials)
  end

  def log_out!
    authenticator.log_out
    reset_session
  end

  def logged_in?
    authenticator.logged_in?
  end
  helper_method :logged_in?

  def authenticator
    @authenticator ||= Authenticator.new(session)
  end
end
