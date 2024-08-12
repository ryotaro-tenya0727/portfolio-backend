require 'rails_helper'

RSpec.describe "日記管理機能 Admin::Diaries", type: :request do
  let!(:user) { create(:user) }
  let(:headers_with_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }
  let(:headers_without_token) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }
  describe "管理ユーザーの日記取得機能 GET /admin/users/:user_id/diaries" do
    let(:diary_num) { 5 }

    before do
      create_list(:diary, diary_num, user: user)
    end

    context '正常系' do
      let!(:current_user) { create(:user, role: 'admin') }
      it 'ユーザーが管理者権限を持つ場合あるユーザーの日記を取得できること' do
        authorization_stub
        get admin_user_diaries_path(user), headers: headers_with_token
        expect(body['data'].count).to eq(diary_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      let!(:current_user) { create(:user, role: 'general') }
      it 'ユーザーが管理者権限を持たない場合あるユーザーの日記を取得できないこと' do
        authorization_stub
        get admin_user_diaries_path(user), headers: headers_with_token
        expect(response).to have_http_status(403)
      end
    end
  end

    describe "管理ユーザーの日記削除機能 DELETE /admin/diaries/:id" do
    let!(:diary) {create(:diary)}
    let(:request_hash) { { headers: headers_with_token} }
    let(:http_request) { delete admin_diary_path(diary), headers: headers_with_token }
    context '正常系' do
      let!(:current_user) { create(:user, role: 'admin') }
      it 'ユーザーが管理者権限を持つ場合あるユーザーの日記を削除できること' do
        authorization_stub
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      let!(:current_user) { create(:user, role: 'general') }
      it 'ユーザーが管理者権限を持たない場合あるユーザーの日記を削除できないこと' do
        authorization_stub
        http_request
        expect(response).to have_http_status(403)
      end
    end
  end
end
