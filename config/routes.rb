Yummymark::Application.routes.draw do
  get "users/show"
 devise_for :users
 resources :users, only: [:show, :update, :index]
 resources :topics, only: [:index, :create]
 resources :bookmarks

 root to: 'bookmarks#index'
end
