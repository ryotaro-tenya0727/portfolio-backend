require 'rails_helper'

RSpec.describe "ユーザー管理機能 Admin::Users", type: :request do
  let(:headers_with_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }
  let(:headers_without_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
  describe "ユーザーの取得 GET /admin/users" do
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

  describe "ユーザーの削除 DELETE /admin/users/:user_id/diaries/:id" do
    let!(:general_user) {create(:user)}
    let(:request_hash) { { headers: headers_with_token} }
    let(:http_request) { delete admin_user_path(general_user), request_hash }

    context '正常系' do
      let!(:current_user) { create(:user, role: 'admin') }
      it 'ユーザーが管理者権限を持つ場合ユーザーを削除できること' do
        authorization_stub
        expect{ http_request }.to change { User.count }.by(-1)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      let!(:current_user) { create(:user, role: 'general') }
      it 'ユーザーが管理者権限を持たない場合ユーザーを削除できないこと' do
        authorization_stub
        http_request
        expect(response).to have_http_status(403)
      end
    end
  end
end
