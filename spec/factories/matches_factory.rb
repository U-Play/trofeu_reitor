FactoryGirl.define do

  factory :match do
    start_datetime { DateTime.now }
    association :tournament 
    association :location 
    association :format 

    after(:create) do |m|
      m.team_one_id = FactoryGirl.create(:team, tournament_id: m.tournament_id).id
      m.team_two_id = FactoryGirl.create(:team, tournament_id: m.tournament_id).id
      m.save
    end

  end
end

