class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { "status": '自動push' }, status: :ok
  end
end
