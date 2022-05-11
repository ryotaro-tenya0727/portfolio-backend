require 'rails_helper'

RSpec.describe "Api::V1::User::Diaries", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/user/diaries/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/user/diaries/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/user/diaries/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/api/v1/user/diaries/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/user/diaries/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/user/diaries/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
