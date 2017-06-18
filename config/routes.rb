Rails.application.routes.draw do
  root 'static#welcome'
  resources :users
  resources :attractions
  resources :rides
  resources :sessions
end
