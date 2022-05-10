require 'rails_helper'

RSpec.describe 'ヘルスチェック Api::V1::HeathChecks', type: :request do
  describe 'ヘルスチェック確認 GET /api/v1/health_check' do
    it 'ヘルスチェックが成功すること' do
      get api_v1_health_check_path
      expect(response).to have_http_status(:ok)
    end
  end
end
