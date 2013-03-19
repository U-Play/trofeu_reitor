Uplay::Application.routes.draw do
  root to: 'static_pages#home'

  ActiveAdmin.routes(self)

  devise_for :users
  devise_for :users, ActiveAdmin::Devise.config
end
