FactoryGirl.define do

  factory :sport do
    sequence(:name) { |n| "Sport#{n}" }
  end
end
