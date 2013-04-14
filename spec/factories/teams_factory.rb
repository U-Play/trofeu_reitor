FactoryGirl.define do

  factory :team do
    sequence(:name) { |n| "Team#{n}" }
    association :tournament 

    after(:create) do |t|
     t.athletes << FactoryGirl.create(:user, role: Role.find_by_name('athlete'))
    end
  end
end

