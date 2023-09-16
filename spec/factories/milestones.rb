FactoryBot.define do
  factory :milestone do
    project { nil }
    title { "MyString" }
    status { "MyString" }
    due_data { "2023-09-15" }
  end
end
