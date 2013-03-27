FactoryGirl.define do

  factory :match do
    start_date { Time.now }
    end_date { Time.now  }
    association :tournament 
    association :location 
    # association :team_one, factory: :team
    # association :team_two, factory: :team

    after(:create) do |m|
      m.team_one_id = FactoryGirl.create(:team, tournament_id: m.tournament_id).id
      m.team_two_id = FactoryGirl.create(:team, tournament_id: m.tournament_id).id
      # m.team_one.tournament_id = m.tournament_id
      # m.team_two.tournament_id = m.tournament_id
    end

  end
end

