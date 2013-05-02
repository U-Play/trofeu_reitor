FactoryGirl.define do

  factory :user do
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
    sequence(:password) { |n| "bigpassword#{n}" }
    sequence(:password_confirmation) { |n| "bigpassword#{n}" }
    association :role

    factory :cr7 do
      first_name 'Cristiano'
      last_name 'Ronaldo'
      email 'cr7@uplay.com'
      password 'user'
      password_confirmation 'user'
    end

    factory :messi10 do
      first_name 'Lionel'
      last_name 'Messi'
      email 'messi@uplay.com'
      password 'user'
      password_confirmation 'user'
    end

    factory :manager do
      first_name 'Mister'
      last_name 'Manager'
      email 'manager@uplay.com'
      password 'manager'
      password_confirmation 'manager'
    end
  end
end