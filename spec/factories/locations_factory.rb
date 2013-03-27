FactoryGirl.define do

  factory :location do
    sequence(:city) { |n| "City#{n}" }
  end
end

