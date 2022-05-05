require 'rails_helper'

RSpec.describe "Api::V1::Users::RecommendedMembers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/users/recommended_members/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/users/recommended_members/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/api/v1/users/recommended_members/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/users/recommended_members/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/users/recommended_members/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
