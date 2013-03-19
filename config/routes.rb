Uplay::Application.routes.draw do
  root to: 'tournaments#new'
  resources :tournaments

  ActiveAdmin.routes(self)

  devise_for :users
  # devise_for :admins, ActiveAdmin::Devise.config.merge(class_name: 'User')
end
