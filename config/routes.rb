Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get :health_check, to: 'health_check#index'
      resources :posts
      resources :users
    end
  end
end
