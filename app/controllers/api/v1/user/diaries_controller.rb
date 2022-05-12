class Api::V1::User::DiariesController < ApplicationController
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    authorize([:user, RecommendedMember])
    diaries = current_user.recommended_members.find_by(uuid: params[:uuid]).diaries.all
    render_json = DiaryListSerializer.new(diaries).serializable_hash.to_json
    # exception handling 404 in concern/api/exception_handler.rb
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    diary = current_user.diaries.build(diary_params)
    diary.save!
  rescue ActiveRecord::RecordInvalid => e
    render400(e, recommended_member.errors.full_messages)
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def diary_params
    params.require(:diary).permit(:event_name, :event_date, :event_venue, :event_polaroid_count, :impressive_memory, :impressive_memory_detail, :status).merge(recommended_member_id: params[:recommended_member_id])
  end

  def set_diary
    @recommended_member = current_user.recommended_members.find_by(uuid: params[:uuid])
    # exception handling 404 in concern/api/exception_handler.rb
  end
end
