require 'rails_helper'

RSpec.describe "ユーザーに関するランキングを取得 Api::V1::User::Rankings", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end
  describe "総チェキ数のランキングを取得 /api/v1/user/rankings/total_polaroid_count" do
    let!(:request_hash) { { headers: headers} }
    let(:http_request) { get total_polaroid_count_api_v1_user_rankings_path, headers: headers }
    before do
      create_list(:diary, 5)
    end
    context "正常系" do
      it "ユーザーが総チェキ数のランキングを取得できること" do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
