class User::RecommendedMemberSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :uuid, :nickname, :group, :first_met_date

  # チェキ総数、登録した日記、出会ってから経過した日数
end
