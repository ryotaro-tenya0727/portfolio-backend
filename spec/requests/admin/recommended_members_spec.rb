require 'rails_helper'

RSpec.describe "Admin::RecommendedMembers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/admin/recommended_members/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/admin/recommended_members/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/recommended_members/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/admin/recommended_members/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/admin/recommended_members/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
