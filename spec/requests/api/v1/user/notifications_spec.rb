require 'rails_helper'

RSpec.describe "通知機能 Api::V1::User::Notifications", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    # authorize_requestメソッドが呼ばれたらcurrent_userを返す。
    # SecuredControllerのcurrent_userメソッドが呼ばれたらlet!(:current_user)を返す。
    authorization_stub
  end

  describe "フォローされたときの通知を取得 GET /api/v1/user/notifications" do
    let!(:other_user) { create(:user) }
    let!(:other_user2) { create(:user) }
    let!(:follow_request_hash) { { headers: headers, params: { id: other_user.id }.to_json } }
    let(:follow_request) { post api_v1_user_user_relationships_path, follow_request_hash }
    let!(:notification_request_hash) { { headers: headers } }
    let(:notification_request) { get api_v1_user_notifications_path, notification_request_hash }
    context "正常系" do
      it "ユーザーをフォローーすると通知が作成されること" do
        expect{ follow_request }.to change { Notification.all.size }.by(1)
        expect(Notification.first.checked).to eq(false)
        # expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it "ユーザーにフォローされた時に通知を受け取れること" do
        other_user.follow(current_user)
        other_user.create_follow_notification(current_user)
        other_user2.follow(current_user)
        other_user2.create_follow_notification(current_user)
        notification_request
        expect(body['data'].size).to eq(2)
        expect(Notification.all.pluck(:checked).tally[true]).to eq(2)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
