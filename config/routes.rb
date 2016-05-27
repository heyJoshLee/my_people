Rails.application.routes.draw do

  get "ui(/:action)", controller: "ui"
  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  root to: "pages#home"

  resources :users
 
end
