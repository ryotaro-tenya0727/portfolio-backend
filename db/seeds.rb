# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  #ユーザーをまとめて生成する
  1000.times do |n|
    user = User.create!(
                  sub: Faker::Number.number(digits: 10),
                  name: Faker::Name.name  ,
                  role: :general,
    )

    member = RecommendedMember.create(
        user: user,
        nickname: "推しメン#{n}",
    )

    Diary.create(
      user: user,
      recommended_member_id: member.id,
      event_name: "イベント#{n}",
      event_venue: "会場#{n}",
      event_polaroid_count: n,
      status: :published
    )
  end
end


# # #掲示板をまとめて生成する
# 20.times do |index|
#   member = RecommendedMember.create(
#       user: User.offset(rand(User.count)).first,
#       nickname: "ニックネーム#{index}",
#   )

#   Diary.create{
#     recommended_member: member
#   }
# end
