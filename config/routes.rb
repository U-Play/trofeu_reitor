Uplay::Application.routes.draw do
  root to: 'static_pages#home'
  mount Citygate::Engine => '/'
end
