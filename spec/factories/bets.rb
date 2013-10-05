# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bet do
    team_id 1
    week_id { create(:week).id }
  end
end
