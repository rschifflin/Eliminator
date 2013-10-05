# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    sequence(:email) { |n| "#{Faker::Internet.email}#{n}" }
    password "password"
  end
end
