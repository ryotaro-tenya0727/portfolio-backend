require 'rails_helper'

RSpec.describe '推しメン登録機能 Api::V1::Users::RecommendedMembers', type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらlet!(:current_user)を返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe 'ユーザーが推しメンを閲覧 GET api/v1/user/recommended_members' do
    let(:recommended_member_num) { 4 }
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
    let!(:request_hash) { { headers: headers, params: { recommended_member: attributes_for(:recommended_member) }.to_json } }
    let(:http_request) { post api_v1_user_recommended_members_path, headers: headers, params: { recommended_member: attributes_for(:recommended_member) }.to_json  }

    context '正常系' do
      it '推しメンが新規作成されること' do
        expect{ http_request }.to change { current_user.recommended_members.count }.by(1)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      let(:http_request) { post api_v1_user_recommended_members_path, headers: headers, params: { recommended_member: attributes_for(:recommended_member, nickname: '')}.to_json  }
      it 'ニックネームが未入力の場合、推しメンが作成されないこと' do
        http_request
        expect(response).to_not be_successful
        expect(response).to have_http_status(400)
      end
    end
  end

  describe 'ユーザーが推しメンの詳細を閲覧 GET /api/v1/user/recommended_members/:id' do
    let!(:recommended_member) { create(:recommended_member, user: current_user) }
    let(:http_request) { get api_v1_user_recommended_member_path(recommended_member.id), headers: headers }

    before do
      create(:diary, :published, recommended_member: recommended_member, user: current_user)
    end

    context '正常系' do
    it '推しメンの詳細が閲覧できること' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'ユーザーが推しメンを編集 PUT /api/v1/user/recommended_members/:id' do
    let!(:recommended_member) { create(:recommended_member, user: current_user) }
    let!(:request_hash) { { headers: headers, params: { recommended_member: { nickname: 'change' } }.to_json } }
    let(:http_request) { put api_v1_user_recommended_member_path(recommended_member.id), headers: headers, params: { recommended_member: { nickname: 'change' } }.to_json }

    context '正常系' do
      it '推しメンを編集できること' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context '異常系' do
      let(:http_request) { put api_v1_user_recommended_member_path(recommended_member.id), headers: headers, params: { recommended_member: attributes_for(:recommended_member, nickname: '') }.to_json }
      it 'ニックネームが未入力の場合、推しメンを編集できないこと' do
        http_request
        expect(response).to_not be_successful
        expect(response).to have_http_status(400)
      end
    end

    context '異常系' do
      let!(:another_recommended_member) { create(:recommended_member) }
      let(:another_http_request) { put api_v1_user_recommended_member_path(another_recommended_member.id), headers: headers, params: { recommended_member: { nickname: 'change' } }.to_json }
      it '他のユーザーが作成した推しメンを編集できないこと' do
        another_http_request
        expect(response).to_not be_successful
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'ユーザーが推しメンを削除 DELETE api/v1/user/recommended_members/:id' do
    let!(:recommended_member) { create(:recommended_member, user: current_user) }
    let!(:request_hash) { { headers: headers} }
    let(:http_request) { delete api_v1_user_recommended_member_path(recommended_member.id), headers: headers }
    context '正常系' do
      it '推しメンを削除できること' do
        expect{ http_request }.to change { current_user.recommended_members.count }.by(-1)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
