require 'resque/server'


Uplay::Application.routes.draw do

  root to: 'static_pages#home'

  # namespace :admin do
  #   resources :users, :as => 'athletes' do
  #     resources :penalties
  #   end
  # end

  devise_for :users

  resources :users, only: [:show, :edit, :update] do
    post '/request-validation' => 'users#request_validation', as: :request_validation
  end

  ActiveAdmin.routes(self)
  # devise_for :admins, ActiveAdmin::Devise.config.merge(class_name: 'User')

	mount Resque::Server, at: "/resque"

end
