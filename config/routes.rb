Rails.application.routes.draw do

  get "ui(/:action)", controller: "ui"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "sign_out", to: "sessions#destroy"
  
  get "event_not_found", to: "events#not_found"

  root to: "pages#home"

  resources :users, except: [:index] do
    resources :comments, only: [:create]
  end

  resources :groups do
    resources :announcements, only: [:create, :destroy] do
      collection { post :sort }
    end
    
    resources :comments, only: [:create]
    resources :memberships, only: [:create, :destroy]
  end

  resources :events do
    resources :announcements, only: [:create, :destroy] do
      collection { post :sort }
    end

    resources :comments, only: [:create]
    resources :rsvps, only: [:create]
  end

  resources :categories, only: [:new, :create, :show, :index]

 
end