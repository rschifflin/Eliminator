require 'spec_helper'

describe Bet do
  let(:team) { create(:team) }
  let(:week) { create(:week) }
  let(:user) { create(:user) }
  let(:season) { create(:season) }

  it { should belong_to(:team) }
  it { should belong_to(:week) }
  it { should belong_to(:user) }

  context "bet validations" do
    let(:team1) { create(:team) }
    let(:team2) { create(:team) }
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:week1) { create(:week, season: season) }
    let(:week2) { create(:week, season: season) }

    specify "A single user cannot bet the same team more than once in a season" do
      bet_initial = create(:bet, team: team1, week: week1, user: user1)
      bet = build(:bet, team: team1, week: week2, user: user1) 
      expect(bet).to be_invalid
    end

    specify "Different users can bet the same team more than once in a season" do
      bet_initial = create(:bet, team: team1, week: week1, user: user1)
      bet = build(:bet, team: team1, week: week1, user: user2) 
      expect(bet).to be_valid
    end

    specify "The same user can bet the same team in different seasons" do
      last_season_week = create(:week, season: create(:season))
      Week.stub(:current).and_return(last_season_week, week1)
      bet_initial = create(:bet, team: team1, week: last_season_week, user: user1)
      bet = build(:bet, team: team1, week: week1, user: user1) 
      expect(bet).to be_valid
    end

    specify "Bets cannot be placed on weeks that are in progress" do
      bet = build(:bet, team: team1, week: week1, user: user1)
      expect{ week1.on_game_start }.to change { bet.valid? }.from(true).to(false)
    end

    specify "Bets cannot be placed on weeks that are in finished" do
      bet = build(:bet, team: team1, week: week1, user: user1)
      expect{ week1.finish }.to change { bet.valid? }.from(true).to(false)
    end

    specify "Bets cannot be placed outside the current week" do
      Week.stub(:current) { week2 }
      bet = build(:bet, team: team1, week: week1, user: user1)
      expect(bet).to be_invalid
    end

  end

  specify "The same user saving a bet in the same week will overwrite his previous bet" do
    old_team = create(:team, name: "Oldies")
    new_team = create(:team, name: "Newbies")
    bet_old = build(:bet, user: user, week: week, team: old_team)
    bet_new = create(:bet, user: user, week: week, team: new_team)
    expect(user.bets).to eq [bet_new]
  end

  specify "The same user saving a bet in different weeks will not overwrite his previous bet" do
    new_week = create(:week, season: season)
    old_team = create(:team, name: "Oldies")
    new_team = create(:team, name: "Newbies")

    Week.stub(:current).and_return(week, new_week)
    bet_old = create(:bet, user: user, week: week, team: old_team)
    bet_new = create(:bet, user: user, week: new_week, team: new_team)
    expect(user.bets).to include(bet_old, bet_new)
  end

  specify "Bet has a factory" do
    expect(create(:bet)).to be_valid
  end
end
