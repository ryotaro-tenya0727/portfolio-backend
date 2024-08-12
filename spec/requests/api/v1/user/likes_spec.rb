require 'rails_helper'

RSpec.describe "いいね機能 Api::V1::User::Likes", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe "ユーザーが選択した日記をいいね POST /api/v1/user/likes" do
    let!(:diary) { create(:diary) }
    let!(:request_hash) { { headers: headers, params: { id: diary.id }.to_json } }
    let(:http_request) { post api_v1_user_likes_path, headers: headers, params: { id: diary.id }.to_json }
    context "正常系" do
      it "ユーザーが選択した日記をいいねできること" do
        http_request
        puts response.body
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context "異常系" do
      before do
        current_user.like(diary)
      end
      it "すでにいいねした日記をいいねできないこと" do
        http_request
        expect(response).to_not be_successful
        expect(response).to have_http_status(400)
      end
    end
  end

  describe "ユーザーが選択した日記のいいねを解除 DELETE /api/v1/user/likes/:id" do
    let!(:diary) { create(:diary) }
    let!(:request_hash) { { headers: headers} }
    let(:http_request) { delete api_v1_user_like_path(diary), headers: headers }
    context "正常系" do
      it "ユーザーが選択した日記のいいねを解除できること" do
        current_user.like(diary)
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
