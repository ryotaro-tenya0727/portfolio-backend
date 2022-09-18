class User::RecommendedMembersSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :nickname, :group, :first_met_date

  attribute :total_member_polaroid_count do |object|
    object.diaries.pluck(:event_polaroid_count).sum
  end

  attribute :diaries_count do |object|
    object.diaries.size
  end

  # 出会ってから経過した日数
  attribute :number_of_days do |object|
    days = (Time.zone.today - (object.first_met_date || Time.zone.today)).to_i
    days.negative? ? 0 : days
  end
end
