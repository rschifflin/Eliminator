# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :team do
    name { Faker::Commerce.product_name.pluralize }
    location { Faker::Address.city }
  end
end
