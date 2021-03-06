Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      get :health_check, to: 'health_check#index'
      resources :users, only: [:create, :index] do
        get 'user_info', on: :collection
        delete 'destroy', on: :collection
      end
      resources :diaries, only: [:index, :show]
      namespace :user do
        resources :recommended_members, shallow: true do
          resources :diaries
        end
        post 's3_presigned_url', to: 's3_presigned_urls#diary_presigned_url'
      end
    end
  end

  namespace :admin, format: 'json' do
    resources :users, shallow: true do
      resources :diaries
    end
  end
end
