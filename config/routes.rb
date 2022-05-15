Rails.application.routes.draw do
  get '/login', to 'sessions#new'
  post '/login', to 'session#create'
  delete '/logout', to: 'sessions#destroy'
end
