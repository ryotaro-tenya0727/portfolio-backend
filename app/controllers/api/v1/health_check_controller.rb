class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { "status": '200' }, status: :ok
  end
end
