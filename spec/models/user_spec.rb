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
      let(:weeks) { [double(Week), double(Week), double(Week)] }
      let!(:bet1) { double(Bet, week: weeks[0]) }
      let!(:bet2) { double(Bet, week: weeks[1]) }
      let!(:bet3) { double(Bet, week: weeks[2]) }
      #let!(:bet1) { double(Bet) { user: user, } create(:bet, user: user, week: create(:week, season: season, progress: :finished)) }
      #let!(:bet2) { create(:bet, user: user, week: create(:week, season: season, progress: :finished)) }
      #let!(:bet3) { create(:bet, user: user, week: create(:week, season: season)) }
      it "returns the bet" do
        Week.stub(:current) { weeks[2] }
        user.stub(:bets) { [bet1, bet2, bet3] }
        expect(user.current_bet).to eq bet3
      end
    end

    context "With bets in multiple seasons" do
      let(:old_week_1) { double(Week) }
      let(:new_week_1) { double(Week) }
      let(:old_week_2) { double(Week) }
      let(:bet1) { double(Bet, week: old_week_1) }
      let(:bet2) { double(Bet, week: new_week_1) }
      let(:bet3) { double(Bet, week: old_week_2) }

      it "returns the bet of the latest season+week" do
        Week.stub(:current) { new_week_1 } 
        user.stub(:bets) { [bet1, bet2, bet3] }
        expect(user.current_bet).to eq bet2
      end
    end

    context "With only old bets" do
      let(:old_week) { double(Week) }
      let(:new_week) { double(Week) }
      let(:bets) { [double("Bet", week: :old_week), double("Bet", week: :old_week), double("Bet", week: :old_week)] }
      it "returns nil" do
        Week.stub(:current) { new_week }
        user.stub(:bets) { bets }
        expect(user.current_bet).to eq nil
      end
    end
  end
end

