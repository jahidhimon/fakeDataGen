# frozen_string_literal: true

Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'fake_users#index'
  resources :fake_users, only: [:index]
end
