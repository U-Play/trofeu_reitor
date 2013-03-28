FactoryGirl.define do

  factory :highlight do
    sequence(:name) { |n| "Highlight#{n}" }
    sequence(:description) { |n| "Highlight's #{n} Description" }
    association :sport
  end
end
