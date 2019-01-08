Rails.application.routes.draw do

  root 'static_pages#home'

  # StaticPagesContorollerアクションへのroutes
  get '/help',    to: 'static_pages#help'
  get '/about',   to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  # UsersControllerアクションへのroutes
  get '/signup',  to: 'users#new'
  resources :users

  # SessionControllerアクションへのroutes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # Placeリソースのルーティング
  resources :places, only: [:index, :show, :create, :destroy, :edit, :update]

  get '/unity', to: 'static_pages#unity'

  # ユーザー登録のルーティングにPOSTリクエストを追加する
  post '/signup',  to: 'users#create'
end
