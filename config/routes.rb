Rails.application.routes.draw do
  root 'static_pages#home'

  get 'static_pages/home'
  get '/signup', to: 'users#new'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  if Rails.env.development?
    # http://localhost:3000/letter_opener にアクセスすると送信したメール確認できる
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
