class Api::V1::DiariesController < ApplicationController
  def index
    diaries = Diary.all
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def show
    diary = Diary.find_by(uuid: params[:uuid])
    render_json = DiaryListSerializer.new(diary).serializable_hash.to_json
    render json: render_json, status: :ok
  end
end
