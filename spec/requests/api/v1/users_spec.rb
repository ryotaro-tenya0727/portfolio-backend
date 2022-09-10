require 'rails_helper'

RSpec.describe 'ユーザー登録 Api::V1::Users', type: :request do
  let!(:current_user) { create(:user) }
  let(:headers_with_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }
  let(:headers_without_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
  let(:data) { { user: { name: 'test_name' } } }

  describe 'ユーザー登録 POST /api/v1/users' do
    it 'JWTトークンを持ったユーザーが、ユーザー登録できること' do
      registration_stub
      post '/api/v1/users', params: data, headers: headers_with_token
      expect(response).to have_http_status(:ok)
    end

    it 'トークンを持たないユーザーに、認証エラーを送信すること' do
      registration_exception_stub
      post '/api/v1/users', params: data, headers: headers_without_token
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'ユーザー情報の取得 GET /api/v1/users/user_info' do
    it 'JWTトークンを持ったユーザーが、ユーザー情報を取得できること' do
      authorization_stub
      get '/api/v1/users/user_info', headers: headers_with_token
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'ユーザーの退会 GET /api/v1/users/destroy' do
    it 'JWTトークンを持ったユーザーが、退会できること' do
      authorization_stub
      expect{ delete '/api/v1/users/destroy', headers: headers_with_token }.to change { User.count }.by(-1)
      expect(response).to be_successful
      expect(response).to have_http_status(204)
    end
  end

  describe 'ユーザーがフォローしているユーザーを閲覧GET /api/v1/users/followers' do
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user3) { create(:user) }
    let!(:request_hash) { { headers: headers} }
    let(:http_request) { get following_api_v1_users_path, request_hash }
    it 'ユーザーがフォローしているユーザーを閲覧できること' do
      authorization_stub
      current_user.follow(other_user1)
      current_user.follow(other_user2)
      current_user.follow(other_user3)
      http_request
      expect(body['data'].count).to eq(3)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end

    describe 'ユーザーがフォローされているユーザーを閲覧 GET /api/v1/users/following' do
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user3) { create(:user) }
    let!(:request_hash) { { headers: headers} }
    let(:http_request) { get followers_api_v1_users_path, request_hash }
    it 'ユーザーがフォローしているユーザーを閲覧できること' do
      authorization_stub
      other_user1.follow(current_user)
      other_user2.follow(current_user)
      other_user3.follow(current_user)
      http_request
      expect(body['data'].count).to eq(3)
      expect(response).to be_successful
      expect(response).to have_http_status(200)
    end
  end
end
