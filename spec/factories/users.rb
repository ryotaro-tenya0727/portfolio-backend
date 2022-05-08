FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test-user-#{n}" }
    sequence(:sub) { |n| "test-user-#{n}" }
    role { :general }
  end
end
