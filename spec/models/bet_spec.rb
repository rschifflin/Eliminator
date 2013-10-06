require 'spec_helper'

describe Bet do
  let(:team) { create(:team) }
  let(:week) { create(:week) }
  let(:user) { create(:user) }
  let(:season) { create(:season) }

  it { should belong_to(:team) }
  it { should belong_to(:week) }
  it { should belong_to(:user) }

  specify "A single user cannot bet the same team more than once in a season" do
    week1 = create(:week, season: season)
    week2 = create(:week, season: season)
    bet_initial = create(:bet, team: team, week: week1, user: user)
    bet_duplicate = build(:bet, team: team, week: week2, user: user) 
    expect(bet_duplicate).to be_invalid
  end

  specify "Different users can be the same team more than once in a season" do
    user_a = create(:user)
    user_b = create(:user)
    bet_initial = create(:bet, team: team, week: week, user: user_a)
    bet_duplicate = build(:bet, team: team, week: week, user: user_b) 
    expect(bet_duplicate).to be_valid
  end

  specify "The same user can bet the the same team in different seasons" do
    week_a = create(:week, season: create(:season))
    week_b = create(:week, season: create(:season))
    bet_initial = create(:bet, team: team, week: week_a, user: user)
    bet_duplicate = build(:bet, team: team, week: week_b, user: user) 
    expect(bet_duplicate).to be_valid
  end

  specify "The same user can bet the the same team in different seasons" do
    week_a = create(:week, season: create(:season))
    week_b = create(:week, season: create(:season))
    bet_initial = create(:bet, team: team, week: week_a, user: user)
    bet_duplicate = build(:bet, team: team, week: week_b, user: user) 
    expect(bet_duplicate).to be_valid
  end

  specify "The same user saving a bet in the same week will overwrite his previous bet" do
    old_team = create(:team, name: "Oldies")
    new_team = create(:team, name: "Newbies")
    bet_old = create(:bet, user: user, week: week, team: old_team)
    bet_new = create(:bet, user: user, week: week, team: new_team)
    expect(user.bets).to eq [bet_new]
  end

  specify "The same user saving a bet in different weeks will not overrite his previous bet" do
    new_week = create(:week, season: season)
    old_team = create(:team, name: "Oldies")
    new_team = create(:team, name: "Newbies")
    bet_old = create(:bet, user: user, week: week, team: old_team)
    bet_new = create(:bet, user: user, week: new_week, team: new_team)
    expect(user.bets).to include(bet_old, bet_new)
  end

  specify "Bet has a factory" do
    expect(create(:bet)).to be_valid
  end
end
