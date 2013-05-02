FactoryGirl.define do

  factory :match do
    start_datetime { DateTime.now }
    association :tournament 
    association :location 
    association :format 

    after(:build) do |m|
      m.team_one = FactoryGirl.create(:team, tournament_id: m.tournament_id)
      m.team_two = FactoryGirl.create(:team, tournament_id: m.tournament_id)
      m.save
    end

    factory :ronaldo_messi do
      after(:build) do |m|
        m.team_one = FactoryGirl.create(:team_ronaldo, tournament_id: m.tournament_id)
        m.team_two = FactoryGirl.create(:team_messi, tournament_id: m.tournament_id)
        m.save
      end
    end
  end
end

