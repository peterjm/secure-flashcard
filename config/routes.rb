Rails.application.routes.draw do
  get "/login" => "sessions#new", as: 'login'
  get '/auth/google/callback' => 'sessions#create'
  get 'auth/google/error' => 'sessions#error'
  delete "/logout" => "sessions#destroy", as: 'logout'

  resources :cards, only: [:show, :new, :create, :edit, :update]

  root to: "home#show"
end
