# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'home#index'

  # Magic link sign in/up/out and session management
  get 'welcome' => 'sessions#new', as: :sessions_new
  post 'sessions/create' => 'sessions#create', as: :sessions_create
  get 'magic/email' => 'sessions#email', as: :sessions_email
  get 'magic/link' => 'sessions#verify', as: :sessions_verify
  get 'sign-out' => 'sessions#destroy', as: :sessions_destroy
  get 'session/test' => 'sessions#test', as: :sessions_test
end
