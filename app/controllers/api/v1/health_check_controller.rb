class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { "status": '通信OK' }, status: :ok
  end
end
