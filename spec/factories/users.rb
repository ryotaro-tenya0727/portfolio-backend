FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test-name-#{n}" }
    sequence(:sub) { |n| "test-sub-#{n}" }
    role { :general }
  end
end
