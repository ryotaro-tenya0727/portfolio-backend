class Api::V1::User::DiariesController < ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    diaries = current_user.recommended_members.find_by(uuid: params[:uuid]).diaries.all
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    # exception handling 404 in concern/api/exception_handler.rb
    render json: diaries, status: :ok
  end

  def create; end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def diary_params; end

  def set_diary; end
end
