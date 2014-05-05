Yummymark::Application.routes.draw do
 resources :topics, only: [:index, :create]
 resources :bookmarks, only: [:index, :destroy]

 root to: 'bookmarks#index'
end
