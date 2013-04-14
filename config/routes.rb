Uplay::Application.routes.draw do
  root to: 'static_pages#home'

  # namespace :admin do
  #   resources :users, :as => 'athletes' do
  #     resources :penalties
  #   end
  # end

  ActiveAdmin.routes(self)

  devise_for :users
  # devise_for :admins, ActiveAdmin::Devise.config.merge(class_name: 'User')
end
