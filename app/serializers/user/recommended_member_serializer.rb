class User::RecommendedMemberSerializer
  include JSONAPI::Serializer
  attributes :id, :uuid, :nickname, :group, :first_met_date

  attribute :total_member_polaroid_count do |object|
    count = 0
    object.diaries.each do |diary|
      count += diary.event_polaroid_count || 0
    end
    count
  end

  attributes :diaries_count do |object|
    object.diaries.count
  end
  # 出会ってから経過した日数
end
