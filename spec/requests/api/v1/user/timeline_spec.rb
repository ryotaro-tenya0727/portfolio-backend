require 'rails_helper'

RSpec.describe "タイムラインの取得 Api::V1::User::Timelines", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらlet!(:current_user)を返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end
  describe "タイムラインの閲覧 GET /index" do
    let!(:other_user1) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:other_user3) { create(:user) }
    let(:http_request) { get api_v1_user_timeline_index_path, headers: headers }
    before do
      create_list(:diary, 5, user: other_user1)
      create_list(:diary, 5, user: other_user2)
      create_list(:diary, 5, user: other_user3)
      current_user.follow(other_user1)
      current_user.follow(other_user2)
      current_user.follow(other_user3)
    end
    context '正常系' do
      it 'タイムラインを閲覧できること' do
        http_request
        expect(body['data'].count).to eq(15)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
