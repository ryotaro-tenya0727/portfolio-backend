require 'rails_helper'

RSpec.describe "署名URLの取得 Api::V1::User::External::Aws::S3::PresignedUrl::ProfilesController", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    authorization_stub
  end

  describe 'ユーザーがS3へアップロードするための署名URLを取得 POST /api/v1/user/external/aws/s3/presigned_url/profiles' do
    let!(:request_hash) { { headers: headers, params: { presigned_url: {filename: "test"} }.to_json } }
    let(:http_request) { post '/api/v1/user/external/aws/s3/presigned_url/diary_videos', headers: headers, params: { presigned_url: {filename: "test"} }.to_json }

    before do
      allow(Signer).to receive(:presigned_url).and_return("presigned_url")
    end

    context '正常系' do
      it '署名URLを取得できること' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
