FactoryBot.define do
  factory :recommended_member do
    sequence(:nickname) { |n| "test-nickname-#{n}" }
    sequence(:group) { |n| "test-group-#{n}" }
    first_met_date { Date.today.last_year }
  end
end
