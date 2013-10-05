# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :week do
    season { create(:season) }
  end
end
