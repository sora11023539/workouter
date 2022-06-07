Rails.application.routes.draw do
  root 'static_pages#home'

  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  get 'chats', to: 'chats#index'
  get 'chats/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  resources :rooms, only: [:create, :show, :index]

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # Usersコントローラーにfollowing, followersアクション追加
  resources :users do
    member do
      get :following, :followers
    end

    collection do
      get 'search'
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :relationships, only: [:create, :destroy]

  if Rails.env.development?
    # http://localhost:3000/letter_opener にアクセスすると送信したメール確認できる
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
