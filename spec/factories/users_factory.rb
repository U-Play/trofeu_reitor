FactoryGirl.define do

  factory :user do
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
    sequence(:password) { |n| "bigpassword#{n}" }
    sequence(:password_confirmation) { |n| "bigpassword#{n}" }
    association :role
  end
end

