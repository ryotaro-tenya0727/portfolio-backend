Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      get :health_check, to: 'health_check#index'
      resources :users, only: [:create]
      resources :diaries, only: [:index, :show], param: :uuid
      namespace :user do
        resources :recommended_members, only: [:index, :create, :edit, :update, :destroy], shallow: true do
          resources :diaries
        end
        post 's3_presigned_url', to: 's3_presigned_urls#diary_presigned_url'
      end
    end
  end
end
