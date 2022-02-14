OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Rails.application.credentials.google.client_id,
    Rails.application.credentials.google.client_secret,
    name: 'google',
    login_hint: Rails.application.credentials.google.allowed_account

  on_failure do |env|
     strategy = env['omniauth.strategy'].name
     params = {
       message: env['omniauth.error.type'],
       origin: env['omniauth.origin']
     }
     new_path = "#{env['omniauth.error.strategy'].path_prefix}/#{strategy}/error?#{params.to_query}"
     Rack::Response.new(["302 Moved"], 302, 'Location' => new_path).finish
   end
end
