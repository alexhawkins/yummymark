Yummymark::Application.routes.draw do
  get "users/show"
 devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
 resources :users, only: [:show, :update, :index]
 resources :topics, only: [:index, :create, :show]
 resources :bookmarks

 root to: 'bookmarks#index'
 post :incoming, to: 'incoming#create'
end
