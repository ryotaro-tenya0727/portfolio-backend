Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get :health_check, to: 'health_check#index'
      resources :users, only: [:create]
      namespace :user do
        resources :recommended_members, param: :uuid, only: [:index, :create, :edit, :update, :destroy]
        resources :diaries, param: :uuid
      end
    end
  end
end
