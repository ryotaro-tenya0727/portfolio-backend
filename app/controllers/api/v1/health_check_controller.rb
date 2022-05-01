class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { "status": '200ほにたん' }, status: :ok
  end
end
