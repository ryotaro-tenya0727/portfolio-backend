class Api::V1::User::RecommendedMembersController < SecuredController
  before_action :set_recommended_member, only: %i[edit update destroy]

  def index
    authorize([:user, RecommendedMember])
    recommended_members = current_user.recommended_members.all
    render_json = RecommendedMemberSerializer.new(recommended_members).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def create
    authorize([:user, RecommendedMember])
    recommended_member = current_user.recommended_members.build(date_modified_recommended_member_params)
    recommended_member.save!
    render json: { 'register_member': true }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, recommended_member.errors.full_messages)
  end

  def edit
    authorize([:user, @recommended_member])
    render_json = RecommendedMemberSerializer.new(@recommended_member).serializable_hash.to_json
    render json: render_json, status: :ok
  end

  def update
    authorize([:user, @recommended_member])
    @recommended_member.update!(date_modified_recommended_member_params)
    render json: { 'update_member': true }, status: :ok
  rescue ActiveRecord::RecordInvalid => e
    render400(e, @recommended_member.errors.full_messages)
  end

  def destroy
    authorize([:user, @recommended_member])
    @recommended_member.destroy!
    # exception handling 500 in concern/api/exception_handler.rb
    render json: { 'destroy_member': true }, status: :ok
  end

  private

  def recommended_member_params
    params.require(:recommended_member).permit(:nickname, :group, :first_met_date)
  end

  def date_modified_recommended_member_params
    new_params = recommended_member_params
    new_params[:first_met_date] &&= new_params[:first_met_date].to_date
    new_params
  end

  def set_recommended_member
    @recommended_member = current_user.recommended_members.find_by!(uuid: params[:uuid])
    # exception handling 404 in concern/api/exception_handler.rb
  end
end
