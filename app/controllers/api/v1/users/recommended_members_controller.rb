class Api::V1::Users::RecommendedMembersController < SecuredController
  def index; end

  def create
    authorize([:users, RecommendedMember])
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
