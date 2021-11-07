Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/login" => "sessions#new", as: 'login'
  get '/auth/google/callback' => 'sessions#create'
  get '/auth/google/error' => 'sessions#error'
  delete "/logout" => "sessions#destroy", as: 'logout'

  resources :cards, only: [:index, :show, :new, :create, :edit, :update] do
    resources :attempts, only: [:create]
  end

  root to: "home#show"
end
