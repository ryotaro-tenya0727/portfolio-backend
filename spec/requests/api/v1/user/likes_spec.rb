require 'rails_helper'

RSpec.describe "Api::V1::User::Likes", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/user/likes/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/user/likes/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
