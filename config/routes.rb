Rails.application.routes.draw do
  namespace :api do
    resources :alerts, only: [:create]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
