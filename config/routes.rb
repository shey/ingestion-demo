Rails.application.routes.draw do
  namespace :api do
    resources :alerts, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
  resources :alerts, only: [:index]

  root to: "alerts#index"
end
