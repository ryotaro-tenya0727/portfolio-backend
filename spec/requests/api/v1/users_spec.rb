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
      expect(response).to have_http_status(201)
    end

    it 'トークンを持たないユーザーに、認証エラーを送信すること' do
      registration_exception_stub
      post '/api/v1/users', params: data, headers: headers_without_token
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
