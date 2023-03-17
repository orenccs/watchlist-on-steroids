Rails.application.routes.draw do
  devise_for :users
  root to: "movies#index"
  # get "home/show"
  # get "/movies/search", to: "movies#search", as: "movie_search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :lists, except: [:edit, :update] do
    resources :bookmarks, only: [:new, :create]
    resources :reviews, only: :create
  end
  resources :bookmarks, only: :destroy
  resources :reviews, only: :destroy
  resources :movies
  # root to: "users/log_in"
end
