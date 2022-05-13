class RecommendedMemberSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :uuid, :nickname, :group, :first_met_date

  attribute :recommending_user do |object|
    object.user.name.to_s
  end
end
