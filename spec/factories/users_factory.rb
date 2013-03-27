FactoryGirl.define do

  factory :user do
    first_name 'FirstName'
    last_name  'LastName'
    sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
    sequence(:password) { |n| "bigpassword#{n}" }
    sequence(:password_confirmation) { |n| "bigpassword#{n}" }
    confirmed_at { Time.now }
  end
end

