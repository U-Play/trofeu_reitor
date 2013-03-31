Uplay::Application.routes.draw do
  root to: 'tournaments#new'
  resources :tournaments

  devise_for :users
end
