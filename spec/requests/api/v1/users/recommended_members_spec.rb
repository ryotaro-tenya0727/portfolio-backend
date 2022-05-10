require 'rails_helper'

RSpec.describe '推しメン登録機能 Api::V1::Users::RecommendedMembers', type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe 'ユーザーが推しメンを閲覧 GET api/v1/user/recommended_members' do
    let(:recommended_member_num) { 5 }
    let(:http_request) { get api_v1_user_recommended_members_path, headers: headers }

    before do
      create_list(:recommended_member, recommended_member_num, user: current_user)
    end

    context '正常系' do
      it '推しメンを閲覧できること' do
        http_request
        expect(body['data'].count).to eq(recommended_member_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'ユーザーが推しメンを作成 POST api/v1/user/recommended_members' do
    let!(:request_hash) { {} }
    let(:http_request) { post api_v1_user_recommended_members_path, request_hash }
    let!(:request_hash) { { headers: headers, params: { recommended_member: attributes_for(:recommended_member) }.to_json } }

    context '正常系' do
      it '推しメンが新規作成されること' do
        expect{ http_request }.to change{ RecommendedMember.count }.by(1)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      it 'ニックネームが未入力の場合、推しメンが作成されないこと' do

      end
    end
  end

  describe 'ユーザーが推しメンを編集 PUT /api/v1/user/recommended_members/:uuid' do
    context '正常系' do
      it '推しメンを編集できること' do

      end
    end

    context '異常系' do
      it 'ニックネームが未入力の場合、推しメンを編集できないこと' do

      end
    end
  end

  describe 'ユーザーが推しメンを削除 DELETE api/v1/user/recommended_members' do
    context '正常系' do
      it '推しメンを削除できること' do

      end
    end
  end
end
