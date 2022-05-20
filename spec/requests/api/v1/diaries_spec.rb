require 'rails_helper'

RSpec.describe "非ログインユーザーの日記閲覧機能", type: :request do
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }


  describe "非ログインユーザーが日記を閲覧できること GET /api/v1/diaries" do
    let(:diary_num) { 5 }
    let(:http_request) { get api_v1_diaries_path, headers: headers }
    before do
      create_list(:diary, diary_num)
    end
    it "非ログインユーザーがが日記を閲覧できること" do
      http_request
      expect(body['data'].count).to eq(diary_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe "非ログインユーザーが日記の詳細を閲覧できること GET /api/v1/diaries" do
    let!(:diary) { create(:diary) }
    let(:http_request) { get api_v1_diary_path(diary.uuid), headers: headers }
    it "非ログインユーザーがが日記を閲覧できること" do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
