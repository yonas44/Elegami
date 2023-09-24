FactoryBot.define do
  factory :task do
    project_id { nil }
    created_by_id { nil }
    assigned_to_id { nil }
    description { Faker::Lorem.sentence }
  end
end
