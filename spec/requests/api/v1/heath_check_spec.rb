require 'rails_helper'

RSpec.describe 'Api::V1::HeathChecks', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/health_check/'
      expect(response).to have_http_status(:ok)
    end
  end
end
