FactoryGirl.define do

  factory :team_data, class: 'TeamData' do
    association :match
    association :team
  end
end

