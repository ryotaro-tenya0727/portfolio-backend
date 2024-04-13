require 'rails_helper'

RSpec.describe "Api::V1::User::External::Clooudflare::Stream::VideoUploadsController", type: :request do
  let!(:current_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: 'jwt_test_token' } }

  before do
    authorization_stub
    define_success_faraday_mock('/cloudflare_video_upload', { "result" => { "uid" =>  "test_video_uid", "thumbnail" => "test_thumbnail_url" } })
  end

  describe 'POST /api/v1/user/external/cloudflare/stream/video_uploads' do
    let!(:request_hash) { { headers: headers, params: { video_upload: {url: "test_url"} }.to_json } }
    let(:http_request) { post '/api/v1/user/external/cloudflare/stream/video_uploads', request_hash }

    context '正常系' do
      it 'cloudflareへ動画をアップロードできること' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
