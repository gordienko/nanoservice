require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  authenticate :user, lambda { |u| u.admin? } do
    resources :dispatches, only: :index
    mount Sidekiq::Web, at: 'sidekiq'
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        # post "sign_up", to: "registrations#create"
        post "sign_in", to: "sessions#create"
        delete "sign_out", to: "sessions#destroy"
      end
      resources :messages, only: [:create]
    end
  end

  root 'home#index'
end
