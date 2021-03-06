require 'rails_helper'

RSpec.describe "非ログインユーザーの日記閲覧機能", type: :request do
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }


  describe "非ログインユーザーが日記を閲覧できること GET /api/v1/diaries" do
    let(:published_diary_num) { 5 }
    let(:non_published_diary_num) { 5 }
    let(:http_request) { get api_v1_diaries_path, headers: headers }
    before do
      create_list(:diary, published_diary_num, :published)
      create_list(:diary, non_published_diary_num, :non_published)
    end
    it "非ログインユーザーが公開された日記のみを閲覧できること" do
      http_request
      expect(body['data'].count).not_to eq(published_diary_num + non_published_diary_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe "非ログインユーザーが日記の詳細を閲覧できること GET /api/v1/diaries" do
    let!(:diary) { create(:diary, :published) }
    let(:http_request) { get api_v1_diary_path(diary.id), headers: headers }
    it "非ログインユーザーがが日記の詳細を閲覧できること" do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
