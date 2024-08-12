require 'rails_helper'

RSpec.describe "推しメンの日記登録機能 Api::V1::User::Profiles", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe "ユーザーがpyリフィイールを編集 PUT /api/v1/user/profile" do
    let!(:request_hash) { { headers: headers, params: { profile: { name: 'test_name', user_image: "test_image_url", me_introduction: "test_me_introduction" } }.to_json } }
    let(:http_request) { put api_v1_user_profile_path, headers: headers, params: { profile: { name: 'test_name', user_image: "test_image_url", me_introduction: "test_me_introduction" } }.to_json }
    context "正常系" do
      it "ユーザーが選択した推しメンの日記を編集できること" do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
