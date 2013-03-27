FactoryGirl.define do

  factory :tournament do
    sequence(:name) { |n| "Tournament#{n}" }
    sequence(:description) { |n| "Great tournament#{n}" }
    start_date Time.now
    end_date Time.now
    association :sport
    association :format
    association :event#, :start_date => Time.now
    # sport_id Sport.first.id
    # format_id Format.first.id
    # event_id Event.first.id
  end
end
