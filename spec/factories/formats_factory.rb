FactoryGirl.define do

  factory :format do
    sequence(:name) { |n| "Format#{n}" }
    sequence(:description) { |n| "Um formato" }
  end
end
