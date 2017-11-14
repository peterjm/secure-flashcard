Rails.application.routes.draw do
  get "/login" => "sessions#new", as: 'login'
  get '/auth/google/callback' => 'sessions#create'
  get 'auth/google/error' => 'sessions#error'
  delete "/logout" => "sessions#destroy", as: 'logout'

  root to: "home#show"
end
