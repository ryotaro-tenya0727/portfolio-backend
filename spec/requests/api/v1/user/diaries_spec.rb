require 'rails_helper'

RSpec.describe "推しメンの日記登録機能 Api::V1::User::Diaries", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe "ユーザーが選択した推しメンの日記を閲覧 GET /api/v1/user/diaries" do
    let(:diary_num) { 5 }
    let!(:recommended_member) { create(:recommended_member, user: current_user) }
    # params[:uuid]でrecommended_memberのuuidを取得
    let(:http_request) { get api_v1_user_recommended_member_diaries_path(recommended_member), headers: headers }

    before do
      create_list(:diary, diary_num, recommended_member: recommended_member, user: current_user)
    end

    context "正常系" do
      it "ユーザーが選択した推しメンの日記を閲覧できること" do
        http_request
        expect(body['data'].count).to eq(diary_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ユーザーが選択した推しメンの日記を作成 POST /api/v1/user/diaries" do
    let!(:request_hash) { { headers: headers, params: { diary: attributes_for(:diary) }.to_json } }
    let!(:recommended_member) { create(:recommended_member, user: current_user) }
    # params[:uuid]でrecommended_memberのuuidを取得
    let(:http_request) { post api_v1_user_recommended_member_diaries_path(recommended_member_id: recommended_member.id), request_hash }
    context "正常系" do
      it "ユーザーが選択した推しメンの日記を作成できること" do
        expect{ http_request }.to change { current_user.recommended_members.find_by(id: recommended_member.id).diaries.count }.by(1)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ユーザーが選択した推しメンの日記の詳細を表示 GET /api/v1/user/diaries/:uuid" do
    context "正常系" do
      it "ユーザーが選択した推しメンの日記の詳細を閲覧できること" do

      end
    end
  end

  describe "ユーザーが選択した推しメンの日記の編集画面を表示 GET /api/v1/user/recommended_members/:uuid/edit" do
    context "正常系" do
      it "ユーザーが選択した推しメンの日記の編集画面を表示できること" do

      end
    end
  end

  describe "ユーザーが選択した推しメンの日記を編集できること PUT /api/v1/user/diaries/:uuid" do
    context "正常系" do
      it "ユーザーが選択した推しメンの日記を編集できること" do

      end
    end
  end

  describe "ユーザーが選択した推しメンの日記を削除できること DELETE /api/v1/user/diaries/:uuid" do
    context "正常系" do
      it "ユーザーが選択した推しメンの日記を削除できること" do

      end
    end
  end
end
