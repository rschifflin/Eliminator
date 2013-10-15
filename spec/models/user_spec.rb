require 'spec_helper'

describe User do
  it { should have_many(:bets) }

  specify "User has username" do
    user = create(:user, username: "FrankBank", email: "Frank@Bank.com", password: "password", password_confirmation: "password") 
    expect(user.username).to eq("FrankBank")
  end

  specify "User has email" do
    user = create(:user, username: "FrankBank", email: "Frank@Bank.com", password: "password", password_confirmation: "password") 
    expect(user.email).to eq("frank@bank.com")
  end

  specify "User has a factory" do
    user = create(:user)
    expect(user).to be_valid
  end

  describe "#current_bet" do
    let(:user) { create(:user) }
    context "With no bets" do
      it "returns nil" do
        expect(user.current_bet).to be_nil
      end
    end

    context "With bets in the most recent week of the most recent season" do
      let(:season) { create(:season) }
      let!(:bet1) { create(:bet, user: user, week: create(:week, season: season, progress: :finished)) }
      let!(:bet2) { create(:bet, user: user, week: create(:week, season: season, progress: :finished)) }
      let!(:bet3) { create(:bet, user: user, week: create(:week, season: season)) }
      it "returns the bet" do
        expect(user.current_bet).to eq bet3
      end
    end

    context "With bets in multiple seasons" do
      let(:old_season) { create(:season, year: 1990, progress: :finished) }
      let(:new_season) { create(:season, year: 2020) }
      let!(:old_week_1) { create(:week, season: old_season) }
      let!(:new_week_1) { create(:week, season: new_season) }
      let!(:old_week_2) { create(:week, season: old_season) }
      let!(:bet1) { create(:bet, user: user, week: old_week_1) }
      let!(:bet2) { create(:bet, user: user, week: new_week_1) }
      let!(:bet3) { create(:bet, user: user, week: old_week_2) }

      it "returns the bet of the latest season+week" do
        expect(user.current_bet).to eq bet2
      end
    end

    context "With only old bets" do
        let(:season) { create(:season) } 
        let!(:bets) { create_list(:bet, 10, user: user, week: create(:week, season: season, progress: :finished)) } 
        let!(:empty_week) { create(:week, season: season) }
      it "returns nil" do
        expect(user.current_bet).to eq nil
      end
    end
  end
end

