require 'rails_helper'

RSpec.describe 'ユーザー登録 Api::V1::Users', type: :request do
  describe 'ユーザー登録 POST /api/v1/users' do
    let(:headers_with_token) { { CONTENT_TYPE: 'application/json', Authorization: 'jwt_test_token' } }
    let(:headers_without_token) { { CONTENT_TYPE: 'application/json' } }
    let(:data) { { user: { name: 'test_name' } } }

    it 'JWTトークンを持ったユーザーが、ユーザー登録できること' do
      registration_stub
      post api_v1_users_path, params: data, headers: headers_with_token
      expect(response).to have_http_status(:ok)
    end

    it 'トークンを持たないユーザーに、認証エラーを送信すること' do
      registration_exception_stub
      post api_v1_users_path, params: data, headers: headers_without_token
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
