class Api::V1::User::RecommendedMembersController < SecuredController
  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all
    render_json = RecommendedMemberSerializer.new(recommended_members).serialized_json
    render json: render_json
  end

  def create
    authorize([:user, RecommendedMember])
    current_user.recommended_members.create!(recommended_member_params)
    render json: { "register_member": true }, status: :ok
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group).merge(first_met_date: params[:recommended_member][:first_met_date].to_date)
  end
end
