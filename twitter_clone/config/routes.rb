Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'users#show', as: 'user'
  get 'users/:id', to: 'users#show', as: 'show_user'
  post '/users/:id/follow', to: 'users#follow', as: 'follow_user'
  post 'users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'

  get '/users/:id/followers', to: 'users#followers', as: 'followers_list'
  get '/users/:id/followees', to: 'users#followees', as: 'followees_list'

  get 'users/:id/follow_another_user', to: 'users#follow_another_user', as: 'follow_another'

  resources :tweets
  root to: 'home#index'
end
