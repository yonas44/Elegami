FactoryBot.define do
  factory :project do
    title { Faker::Lorem.word }
    description { Faker::Lorem.sentence }
    priority { Faker::Number.between(from: 1, to: 10) }
  end
end
