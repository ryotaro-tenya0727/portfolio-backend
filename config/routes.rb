Rails.application.routes.draw do
  namespace :admin, format: 'json' do
    resources :users, shallow: true do
      resources :diaries
    end
  end

  namespace :api, format: 'json' do
    namespace :v1 do
      namespace :user do
        resources :recommended_members, shallow: true do
          resources :diaries
        end

        put 'profile', to: 'profiles#update'

        resources :likes, only: [:create, :destroy]
        resources :notifications, only: :index
        resources :notification_counts, only: :index

        resources :rankings, only: [] do
          collection do
            get 'total_polaroid_count'
          end
        end

        post 's3_presigned_url', to: 's3_presigned_urls#diary_presigned_url'

        resources :timeline, only: [:index] do
          collection do
            get 'follow'
          end
        end

        resources :user_relationships, only: [:index, :create, :destroy] do
          collection do
            post 'search'
          end
        end

        resources :users, only: [:index] do
          collection do
            post 'user_info'
            delete 'destroy'
            get :following, :followers
          end
        end
        post '/pusher_auth', to: 'pusher_auth#create'

        namespace :external do
          namespace :aws do
            namespace :s3 do
              namespace :presigned_url do
                resources :profiles, only: :create
              end
            end
          end
        end
      end

      resources :diaries, only: [:index, :show]


      get :health_check, to: 'health_check#index'

      resources :users, only: [:create, :index]
    end
  end
end
