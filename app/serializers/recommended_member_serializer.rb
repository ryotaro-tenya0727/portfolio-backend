class RecommendedMemberSerializer
  include FastJsonapi::ObjectSerializer
  attributes :uuid, :nickname, :group, :first_met_date

  attribute :recommend_user do |object|
    object.user.name.to_s
  end
end
