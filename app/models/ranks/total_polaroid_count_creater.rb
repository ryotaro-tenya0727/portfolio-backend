class Ranks::TotalPolaroidCountCreater
  def self.create_ranking
    User.all
        .preload(:followers, :recommended_members, :diaries)
        .sort_by { |user| user.diaries.pluck(:event_polaroid_count).sum * -1 }[0..4]
  end
end
