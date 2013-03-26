FactoryGirl.define do

  factory :tournament do
    sequence(:name) { |n| "Tournament#{n}" }
    sequence(:description) { |n| "Great tournament#{n}" }
    start_date Time.now
    end_date Time.now
    s_id { rand(Sport.count-1) + 1 }
    sport_id Sport.find(s_id).id
    f_id { rand(Format.count-1) + 1 }
    format_id Format.find(f_id).id
  end
end
