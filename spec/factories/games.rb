# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    home_team_id ""
    away_team_id ""
    progress :unstarted
  end
end
