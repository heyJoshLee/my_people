Rails.application.routes.draw do

  get "ui(/:action)", controller: "ui"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "sign_out", to: "sessions#destroy"
  
  get "event_not_found", to: "events#not_found"

  root to: "pages#home"

  resources :users, only: [:new, :create]
  resources :groups do
    member do
      post :comment
    end
  end

  resources :events, only: [:new, :create, :show] do
  end

  resources :categories, only: [:new, :create, :show, :index]

 
end