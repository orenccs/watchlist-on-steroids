Rails.application.routes.draw do
  get "home/show"
  get "/movies/search", to: "movies#search", as: "movie_search"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "movies#index"
  resources :lists, except: [:edit, :update] do
    resources :bookmarks, only: [:new, :create]
    resources :reviews, only: :create
  end
  resources :bookmarks, only: :destroy
  resources :reviews, only: :destroy
  resources :movies
end
