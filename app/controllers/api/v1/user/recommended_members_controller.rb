class Api::V1::User::RecommendedMembersController < SecuredController
  before_action :set_recommended_member, only: [:edit, :update, :destroy]

  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all
    render_json = RecommendedMemberSerializer.new(recommended_members).serialized_json
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    current_user.recommended_members.create!(recommended_member_params)
    # 例外処理
    render json: { "register_recommended_member": true }, status: :ok
  end

  def edit
    authorize([:user, @recommended_member])
    render_json = RecommendedMemberSerializer.new(@recommended_member).serialized_json
    render json: render_json
  end

  def update
    authorize([:user, @recommended_member])
    @recommended_member.update!(recommended_member_params)
    # 例外処理
    render json: { "update_recommended_member": true }, status: :ok
  end

  def destroy
    authorize([:user, @recommended_member])
    @recommended_member.destroy!
    # 例外処理
    render json: { "destroy_recommended_member": true }, status: :ok
  end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group).merge(first_met_date: params[:recommended_member][:first_met_date].to_date)
  end

  def set_recommended_member
    @recommended_member = current_user.recommended_members.find_by!(uuid: params[:uuid])
    # 例外処理
  end
end
