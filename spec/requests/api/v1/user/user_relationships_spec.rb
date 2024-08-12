require 'rails_helper'

RSpec.describe "フォロー機能 Api::V1::User::UserRelationships", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe "ユーザーがユーザー一覧を閲覧 GET /api/v1/user/user_relationships" do
    let(:http_request) { get api_v1_user_user_relationships_path, headers: headers }
    context "正常系" do
      it "ユーザーがユーザー一覧を閲覧できること" do
        # byebug
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ユーザーが選択したユーザーをフォロー POST /api/v1/user/user_relationships" do
    let!(:other_user) { create(:user) }
    let(:http_request) { post api_v1_user_user_relationships_path, headers: headers, params: { id: other_user.id }.to_json  }
    context "正常系" do
      it "ユーザーが選択したユーザーをフォローできること" do
        http_request
        puts response.body
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ユーザーが選択したユーザーのフォローを解除 DELETE /api/v1/user/user_relationships/:id" do
    let!(:other_user) { create(:user) }
    let(:http_request) { delete api_v1_user_user_relationship_path(other_user.id), headers: headers }
    context "正常系" do
      it "ユーザーが選択したユーザーのフォローを解除できること" do
        current_user.follow(other_user)
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "ユーザーが指定したワードでユーザーを検索 POST /api/v1/user/user_relationships/search" do
    let(:http_request) { post search_api_v1_user_user_relationships_path, headers: headers, params: {search: {name: "検索"}}.to_json }
    let!(:search_user) { create(:user, name: "検索") }
    before do
      create_list(:user, 3)
    end
    context "正常系" do
      it "ユーザーが選択したワードでユーザーを検索できること" do
        http_request
        expect(body['data'][0]['attributes']['name']).to eq("検索")
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
