Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cards
  resources :decks
  resources :deck_cards
  resources :users, except: [:edit, :update, :destroy]
  resources :sessions, only: [:new, :create]
  delete "/logout", to: "sessions#destroy"
  get "/login", to: "sessions#new"
  get "/search", to: "cards#filter"
  patch "/decks", to: "decks#index"
end
