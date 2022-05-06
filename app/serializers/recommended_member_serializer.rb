class RecommendedMemberSerializer
  include FastJsonapi::ObjectSerializer
  attributes
  attributes :uuid, :nickname, :group, :first_met_date

  attribute :recommend_user do |object|
    "#{object.user.name}"
  end
end
