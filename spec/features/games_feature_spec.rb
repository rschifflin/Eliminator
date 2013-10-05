require 'spec_helper'

describe "The Games page" do
  let(:games_page) { GamesPage.new }
  before { visit games_path }

  context "During a week with games to be played" do
    let(:season) { create(:season) }
    let(:week) { create(:week, season: season) }
    let(:teams) { create_list(:team, 20) }
    before do
      create_list(:game, 10, home_team: teams.sample, away_team: teams.sample, week: week)
      visit games_path
    end

    it "should show me the list of current games this week" do
      expect(games_page.current_games.size).to eq(10)
    end

  end
end
