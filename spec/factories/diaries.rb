FactoryBot.define do
  factory :diary do
    sequence(:event_name) { |n| "test-event_name-#{n}" }
    event_date { Date.today.last_year }
    sequence(:event_venue) { |n| "test-event_venue-#{n}" }
    sequence(:event_polaroid_count) { 5 }
    sequence(:impressive_memory) { |n| "test-impressive_memory-#{n}" }
    sequence(:impressive_memory_detail) { |n| "test-impressive_memory_detail-#{n}" }
    status { :published }
    association :recommended_member
    user { recommended_member.user }
  end
end
