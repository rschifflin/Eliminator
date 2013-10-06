require 'spec_helper'

describe GamesController do
  include Devise::TestHelpers

  context "With a signed-in user with a current bet" do
    let(:user) { create(:user) }
    let!(:bet) { create(:bet, user: user) }
    before { sign_in user }

    describe "#index" do
      let!(:week) { create(:week) }
      it "sets the current user's most recent bet as @bet" do
        get :index, {week_id: week.id}
        expect(assigns["bet"]).to eq bet
      end
       it "sets the week as @week" do
        get :index, {week_id: week.id}
        expect(assigns["week"]).to eq week
       end
    end
  end

  context "With a signed-in user without a current bet" do
    let(:user) { create(:user) }
    let(:old_season) { create(:season, year: 1975) }
    let(:new_season) { create(:season, year: 2025) }
    let!(:old_week) { create(:week, season: old_season) }
    let!(:new_week) { create(:week, season: new_season) }
    let!(:bet) { create(:bet, user: user, week: old_week) }
    before do
      sign_in user
    end

    it "leaves @bet as nil" do
      get :index, {week_id: new_week.id}
      expect(assigns["bet"]).to be_nil
    end 
  end

  context "Without a signed-in user" do
    let(:user) { create(:user) }
    let(:bet) { create(:bet, user: user) }
    let(:week) { create(:week) }
    before { bet }

    describe "#index" do
      it "leaves @bet as nil" do
        get :index, {week_id: week.id}
        expect(assigns["bet"]).to be_nil
      end
    end
  end
end
