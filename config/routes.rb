Rails.application.routes.draw do

  get "ui(/:action)", controller: "ui"
  get "log_in", to: "sessions#new"

  root to: "pages#home"

  resources :users
 
end
