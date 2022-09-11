Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      get :health_check, to: 'health_check#index'

      resources :users, only: [:create, :index]
      resources :diaries, only: [:index, :show]

      namespace :user do
        resources :recommended_members, shallow: true do
          resources :diaries
        end

        post 's3_presigned_url', to: 's3_presigned_urls#diary_presigned_url'

        resources :user_relationships, only: [:index, :create, :destroy] do
          collection do
            post 'search'
          end
        end
        resources :users, only: [:index] do
          collection do
            get 'user_info'
            delete 'destroy'
            get :following, :followers
          end
        end
      end
    end
  end

  namespace :admin, format: 'json' do
    resources :users, shallow: true do
      resources :diaries
    end
  end
end
