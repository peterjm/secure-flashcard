class SessionsController < ApplicationController
  before_action only: [:new, :create, :error], if: :logged_in? do
    redirect_to root_path
  end

  def new
  end

  def create
    email = request.env["omniauth.auth"]['info']['email']
    if log_in!(email)
      redirect_to_return_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def error
    render 'new', status: :unprocessable_entity
  end

  def destroy
    log_out!
    redirect_to login_path
  end

  protected

  def auth_path
    "/auth/google"
  end
  helper_method :auth_path

end
