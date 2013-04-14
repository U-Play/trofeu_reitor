FactoryGirl.define do

  factory :sport do
    sequence(:name) { |n| "Sport#{n}" }
    sequence(:description) { |n| "Sport#{n} Description" }
  end
end
