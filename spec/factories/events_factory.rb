FactoryGirl.define do

  factory :event do
    sequence(:name) { |n| "Event#{n}" }
    start_date { Time.now }
    end_date { Time.now  }
    association :user 
  end
end
