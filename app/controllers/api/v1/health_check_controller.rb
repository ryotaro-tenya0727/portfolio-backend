class Api::V1::HealthCheckController < ApplicationController
  def index
    render json: { "status": 'ありがとうほにたん' }, status: :ok
  end
end
