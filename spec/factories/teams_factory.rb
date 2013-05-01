FactoryGirl.define do

  factory :team do
    # sequence(:name) { |n| "Team#{n}" }
    association :tournament 
    # association :course

    after(:build) do |t|
      t.course = Course.find(rand(Course.count) + 1)
    end

    # after(:create) do |t|
    #  FactoryGirl.create( :team_athlete, 
    #                      athlete: FactoryGirl.create(:user, role: Role.find_by_name('athlete')), 
    #                      team:    t
    #                    )
    # end
  end
end
