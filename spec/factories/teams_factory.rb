FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team #{n}" }
    association :tournament 
    # association :course

    after(:build) do |t|
      t.course = Course.find(rand(Course.count) + 1)
    end

    factory :team_ronaldo do
      after(:build) do |t|
        t.course = Course.find(1)
      end

      after(:create) do |t|
        FactoryGirl.create( :team_athlete, 
                          athlete: FactoryGirl.create(:cr7, role: Role.find_by_name('athlete')), 
                          team:    t
                          )
        t.manager = FactoryGirl.create( :team_athlete, 
                          athlete: FactoryGirl.create(:manager, role: Role.find_by_name('manager')), 
                          team:    t
                          ).athlete
        t.save
      end
    end

    factory :team_messi do
      after(:build) do |t|
        t.course = Course.find(2)
      end

      after(:create) do |t|
        FactoryGirl.create( :team_athlete, 
                          athlete: FactoryGirl.create(:messi10, role: Role.find_by_name('athlete')), 
                          team:    t
                          )
      end
    end
  end
end
