require 'rails_helper'

RSpec.describe "日記管理機能 Admin::Diaries", type: :request do
  let!(:user) { create(:user) }
  let(:headers_with_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }
  let(:headers_without_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
  describe "ユーザー日記の取得 GET /admin/users/:user_id/diaries" do
    let(:diary_num) { 5 }

    before do
      create_list(:diary, diary_num, user: user)
    end

    context '正常系' do
      let!(:current_user) { create(:user, role: 'admin') }
      fit 'ユーザーが管理者権限を持つ場合あるユーザーの日記を取得できること' do
        authorization_stub
        get admin_user_diaries_path(user), headers: headers_with_token
        expect(body['data'].count).to eq(diary_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
