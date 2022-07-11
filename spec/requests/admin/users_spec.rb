require 'rails_helper'

RSpec.describe "ユーザー管理機能 Admin::Users", type: :request do
  let(:headers_with_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }
  let(:headers_without_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
  describe "GET /admin/users" do
    let(:user_num) { 5 }

    before do
      create_list(:user, user_num)
    end

    context '正常系' do
      let!(:current_user) { create(:user, role: 'admin') }
      it 'ユーザーが管理者権限を持つ場合全ユーザーの情報を取得できること' do
        authorization_stub
        get '/admin/users', headers: headers_with_token
        expect(body['data'].count).to eq(user_num + 1)
      end
    end

    context '異常系' do
      let!(:current_user) { create(:user, role: 'general') }
      it '管理者権限を持たないユーザーが全ユーザーの情報を取得できない' do
        authorization_stub
        get '/admin/users', headers: headers_with_token
        expect(body['data']).to eq(nil)
      end
    end
  end
end
